class UploadFilesController < Lina::ApplicationController
  # def create
  define_action :create, {
    name: 'upload files',
    description: '',
    params: {
      type: 'object',
      required: [:Filedata],
      properties: {
        Filedata: {
          type: 'object',
          description: 'file object',
        }
      }
    },
    return: {
    }
  } do
  end
end
