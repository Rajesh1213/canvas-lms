#
# Copyright (C) 2011 Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module Api::V1::TodoItem
  include Api::V1::Assignment
  include Api::V1::Context

  def todo_item_json(assignment, todo_type)
    context_data(assignment).merge({
      :type => todo_type,
      :assignment => assignment_json(assignment),
      :ignore => api_v1_users_todo_ignore_url(assignment.asset_string, todo_type, :permanent => '0'),
      :ignore_permanently => api_v1_users_todo_ignore_url(assignment.asset_string, todo_type, :permanent => '1'),
    }).tap do |hash|
      if todo_type == 'grading'
        hash['needs_grading_count'] = assignment.needs_grading_count
      end
    end
  end
end