module Tr3llo
  module Command
    module List
      module Cards
        extend self

        def execute(key)
          list_id = Entities.parse_id(:list, key)
          assert_list_id!(list_id, key)

          cards = list_cards(list_id)

          interface.print_frame do
            interface.puts(Presenter::List::CardsPresenter.render(cards))
          end
        end

        private

        def list_cards(list_id)
          API::Card.find_all_by_list(list_id)
        end

        def interface
          Application.fetch_interface!()
        end

        def assert_list_id!(list_id, key)
          raise InvalidArgumentError.new("#{key.inspect} is not a valid list key") unless list_id
        end
      end
    end
  end
end