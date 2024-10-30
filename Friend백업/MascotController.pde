class MascotController {
    MascotModel model;
    MascotView view;

    MascotController(MascotModel model, MascotView view) {
        this.model = model;
        this.view = view;
    }

    void update(float width, float height) {
        model.updatePosition(width, height, view);
        view.display(model.x, model.y);
    }
}