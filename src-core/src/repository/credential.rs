#[derive(Debug, thiserror::Error)]
enum Error {
    #[error(transparent)]
    UrlParse(#[from] src::url::parse::Error),
    #[error(transparent)]
    Configuration(#[from] src::config::credential_helpers::Error),
    #[error(transparent)]
    Protocol(#[from] src::credentials::protocol::Error),
    #[error(transparent)]
    ConfigLoad(#[from] src::config::file::init::from_paths::Error),
}

pub fn function(repo: Option<src::Repository>, action: src::credentials::program::main::Action) -> anyhow::Result<()> {
    use src::credentials::program::main::Action::*;
    src::credentials::program::main(
        Some(action.as_str().into()),
        std::io::stdin(),
        std::io::stdout(),
        |action, context| -> Result<_, Error> {
            let url = context
                .url
                .clone()
                .or_else(|| context.to_url())
                .ok_or(Error::Protocol(src::credentials::protocol::Error::UrlMissing))?;

            let (mut cascade, _action, prompt_options) = match repo {
                Some(ref repo) => repo
                    .config_snapshot()
                    .credential_helpers(src::url::parse(url.as_ref())?)?,
                None => {
                    let config = src::config::File::from_globals()?;
                    let environment = src::open::permissions::Environment::all();
                    src::config::credential_helpers(
                        src::url::parse(url.as_ref())?,
                        &config,
                        false,    /* lenient config */
                        |_| true, /* section filter */
                        environment,
                        false, /* use http path (override, uses configuration now)*/
                    )?
                }
            };
            cascade
                .invoke(
                    match action {
                        Get => src::credentials::helper::Action::Get(context),
                        Erase => src::credentials::helper::Action::Erase(context.to_bstring()),
                        Store => src::credentials::helper::Action::Store(context.to_bstring()),
                    },
                    prompt_options,
                )
                .map(|outcome| outcome.and_then(|outcome| (&outcome.next).try_into().ok()))
                .map_err(Into::into)
        },
    )
    .map_err(Into::into)
}
