class GroupsController < ApplicationController
  def join
    result = Groups::Operations::JoinUser.new(params.to_unsafe_h, record: group).call

    if result.success?
      render 'courses/show', locals: { course: course, groups: course.groups }, status: :created
    else
      case error = result.failure
      when Dry::Validation::Result
        flash.now[:error] = error.errors.to_h
        render 'courses/show', locals: { course: course, groups: course.groups }, status: :unprocessable_entity #course_path(group.course)
      else
        render 'courses/show', locals: { course: course, groups: course.groups }, status: :unprocessable_entity #course_path(group.course)
      end
    end
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end

  def course
    @course ||= Course.find(params[:course_id])
  end
end
