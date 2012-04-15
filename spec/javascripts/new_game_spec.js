describe("Create Game", function () {

    it("Should return a NoteModel instance", function () {

        var note = Notes.app.createNote();

        expect(note instanceof Notes.model.NoteModel).toBeTruthy();
    });
});
