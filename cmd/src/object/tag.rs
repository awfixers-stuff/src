use crate::{ext::ObjectIdExt, ObjectDetached, Tag};

impl<'repo> Tag<'repo> {
    /// Decode the entire tag object and return it for accessing all tag information.
    ///
    /// This never allocates.
    ///
    /// Note that the returned commit object does make lookup easy and should be
    /// used for successive calls to string-ish information to avoid decoding the object
    /// more than once.
    pub fn decode(&self) -> Result<src_object::TagRef<'_>, src_object::decode::Error> {
        src_object::TagRef::from_bytes(&self.data)
    }

    /// Decode this tag partially and return the id of its target.
    pub fn target_id(&self) -> Result<crate::Id<'repo>, src_object::decode::Error> {
        src_object::TagRefIter::from_bytes(&self.data)
            .target_id()
            .map(|id| id.attach(self.repo))
    }

    /// Decode this tag partially and return the tagger, if the field exists.
    pub fn tagger(&self) -> Result<Option<src_actor::SignatureRef<'_>>, src_object::decode::Error> {
        src_object::TagRefIter::from_bytes(&self.data).tagger()
    }
}

/// Remove Lifetime
impl Tag<'_> {
    /// Create an owned instance of this object, copying our data in the process.
    pub fn detached(&self) -> ObjectDetached {
        ObjectDetached {
            id: self.id,
            kind: src_object::Kind::Tag,
            data: self.data.clone(),
        }
    }

    /// Sever the connection to the `Repository` and turn this instance into a standalone object.
    pub fn detach(self) -> ObjectDetached {
        self.into()
    }

    /// Retrieve this instance's encoded data, leaving its own data empty.
    ///
    /// This method works around the immovability of members of this type.
    pub fn take_data(&mut self) -> Vec<u8> {
        std::mem::take(&mut self.data)
    }
}
