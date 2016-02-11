runtime! plugin/vim-open-alternate.vim

call vspec#hint({'scope': 'VimOpenAlternateScope()', 'sid': 'VimOpenAlternateSid()'})

describe 's:RemoveLeadingDotSlash'
  it 'removes the leading dot slash from the given path'
    Expect vspec#call('s:RemoveLeadingDotSlash', './spec/controllers/tasks_controller_spec.rb') == 'spec/controllers/tasks_controller_spec.rb'
  end

  it 'leaves paths without leading dot slash alone'
    Expect vspec#call('s:RemoveLeadingDotSlash', 'spec/controllers/tasks_controller_spec.rb') == 'spec/controllers/tasks_controller_spec.rb'
  end
end

describe 's:AlternateFileFor'
  context 'when the path is for a cucumber feature file'
    it 'supports cucumber feature files'
      Expect vspec#call('s:AlternateFileFor', 'features/project_management.feature') == 'features/step_definitions/project_management_steps.rb'
    end
  end

  context 'when the path is for a RSpec file'
    context 'when the file is from a hanami app'
      it 'supports controller rspec files without leading dot slash'
        Expect vspec#call('s:AlternateFileFor', 'spec/web/controllers/users/create_spec.rb') == 'apps/web/controllers/users/create.rb'
      end

      it 'supports controller rspec files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './spec/web/controllers/users/create_spec.rb') == 'apps/web/controllers/users/create.rb'
      end

      it 'supports view rspec files without leading dot slash'
        Expect vspec#call('s:AlternateFileFor', 'spec/web/views/users/create_spec.rb') == 'apps/web/views/users/create.rb'
      end

      it 'supports view rspec files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './spec/web/views/users/create_spec.rb') == 'apps/web/views/users/create.rb'
      end
    end

    context 'when the file is from a rails app'
      it 'supports rspec rails controller files'
        Expect vspec#call('s:AlternateFileFor', 'spec/controllers/tasks_controller_spec.rb') == 'app/controllers/tasks_controller.rb'
      end

      it 'supports rspec rails controller files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './spec/controllers/tasks_controller_spec.rb') == 'app/controllers/tasks_controller.rb'
      end

      it 'supports rspec rails model files'
        Expect vspec#call('s:AlternateFileFor', 'spec/models/task_spec.rb') == 'app/models/task.rb'
      end

      it 'supports rspec rails helper files'
        Expect vspec#call('s:AlternateFileFor', 'spec/helpers/hoopty_spec.rb') == 'app/helpers/hoopty.rb'
      end

      it 'supports rspec rails mailer files'
        Expect vspec#call('s:AlternateFileFor', 'spec/mailers/hoopty_mailer_spec.rb') == 'app/mailers/hoopty_mailer.rb'
      end

      it 'supports rspec ruby/rails lib files'
        Expect vspec#call('s:AlternateFileFor', 'spec/lib/foo_spec.rb') == 'lib/foo.rb'
      end
    end
  end

  context 'when the path is for cucumber step definitions'
    it 'supports cucumber step definition files'
      Expect vspec#call('s:AlternateFileFor', 'features/step_definitions/project_management_steps.rb') == 'features/project_management.feature'
    end
  end

  context 'when the path is for a javascript spec file'
    it 'supports javascript spec files'
      Expect vspec#call('s:AlternateFileFor', 'spec/foo/bar/jacked_spec.js') == 'foo/bar/jacked.js'
    end
  end

  context 'when the path is for a javascript implementation file'
    it 'supports javascript implementation files'
      Expect vspec#call('s:AlternateFileFor', 'foo/bar/jacked.js') == 'spec/foo/bar/jacked_spec.js'
    end
  end

  context 'when the path is for ex unit test files'
    it 'supports ExUnit test files'
      Expect vspec#call('s:AlternateFileFor', 'test/lib/my_awesome_app/supervisor_test.exs') == 'lib/my_awesome_app/supervisor.ex'
    end
  end

  context 'when the path is for elixir implementation files'
    it 'supports elixir implementation files'
      Expect vspec#call('s:AlternateFileFor', 'lib/my_awesome_app/supervisor.ex') == 'test/lib/my_awesome_app/supervisor_test.exs'
    end
  end

  context 'when the path is for ruby implementation'
    context 'when the path is from a hanami app'
      it 'supports controller files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './apps/web/controllers/users/create.rb') == 'spec/web/controllers/users/create_spec.rb'
      end

      it 'supports controller files without leading dot slash'
        Expect vspec#call('s:AlternateFileFor', 'apps/web/controllers/users/create.rb') == 'spec/web/controllers/users/create_spec.rb'
      end

      it 'supports view files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './apps/web/views/users/create.rb') == 'spec/web/views/users/create_spec.rb'
      end

      it 'supports view files without leading dot slash'
        Expect vspec#call('s:AlternateFileFor', 'apps/web/views/users/create.rb') == 'spec/web/views/users/create_spec.rb'
      end
    end

    context 'when the file is from a rails app'
      it 'supports rails controller files'
        Expect vspec#call('s:AlternateFileFor', 'app/controllers/tasks_controller.rb') == 'spec/controllers/tasks_controller_spec.rb'
      end

      it 'supports rails controller files with leading dot slash'
        Expect vspec#call('s:AlternateFileFor', './app/controllers/tasks_controller.rb') == 'spec/controllers/tasks_controller_spec.rb'
      end

      it 'supports rails model files'
        Expect vspec#call('s:AlternateFileFor', 'app/models/task.rb') == 'spec/models/task_spec.rb'
      end

      it 'supports rails helper files'
        Expect vspec#call('s:AlternateFileFor', 'app/helpers/hoopty.rb') == 'spec/helpers/hoopty_spec.rb'
      end

      it 'supports rails mailer files'
        Expect vspec#call('s:AlternateFileFor', 'app/mailers/hoopty_mailer.rb') == 'spec/mailers/hoopty_mailer_spec.rb'
      end

      it 'supports ruby/rails lib files'
        Expect vspec#call('s:AlternateFileFor', 'lib/foo.rb') == 'spec/lib/foo_spec.rb'
      end

      it 'supports rspec rails rake files'
        Expect vspec#call('s:AlternateFileFor', 'spec/bar/foo_rake_spec.rb') == 'bar/foo.rake'
      end

      it 'supports rails rake files'
        Expect vspec#call('s:AlternateFileFor', 'bar/foo.rake') == 'spec/bar/foo_rake_spec.rb'
      end
    end
  end
end
