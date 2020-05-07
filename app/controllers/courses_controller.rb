class CoursesController < ApplicationController
  def index
    courses = Courses::Queries::Index.new(Course, params[:sort_by]).call

    if courses.success?
      courses = courses.value!.map { |c| Courses::Decorators::Record.new(c) }
      render :index, locals: { courses: courses }
    else
      # raise ActiveRecord::StatementInvalid
    end
  end

  def show
    course = Course.find(params[:id])
    groups = course.groups

    render :show, locals: { course: course, groups: groups }
  end
end
