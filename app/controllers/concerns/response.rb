module Response
  def render_json(object)
    render json: object
  end
end
