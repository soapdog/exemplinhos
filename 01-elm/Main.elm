module Exemplo exposing (main)

import Css exposing (..)
import Css.Colors exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)


{-
   O tipo apresentado abaixo simboliza os possiveis estados
   do sinal. Note que é impossível mais que uma luz estar acesa
   ao mesmo tempo pois o tipo algebraico abaixo não permite
   esse tipo de representação.

   Ao construir bons tipos, você elimina toda uma série de
   bugs possíveis
-}


type Sinal
    = TudoApagado
    | Verde
    | Amarelo
    | Vermelho


type alias Model =
    Sinal



{-
   Quem tá vindo de React/Vue/Angular, essas são
   as actions possíveis. No caso só tem uma.
-}


type Msg
    = Acender Sinal


initialModel : Model
initialModel =
    TudoApagado



{-
   É quem processa as ações de ligar ou desligar uma luz.
   Em React ou Vue seria quem lida com as actions.

   O update é a única função que pode alterar o model.
-}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Acender luz ->
            luz



{-
   Constroi uma luzinha. Ele gera HTML no formado:

     tag [atributos] [filhos]

   No nosso caso, cada luz é só uma div com um CSS, ou seja:

     div [css] []

  Além disso, como pode ser visto na descrição do tipo, nossas
  luzinhas geram Msg, ou seja, actions para o update.

-}


luz : Model -> Color -> Sinal -> Html Msg
luz model cor tipo =
    let
        corzinha =
            if model == tipo then
                cor
            else
                silver
    in
    div
        [ css
            [ borderRadius (pct 50)
            , width (px 40)
            , height (px 40)
            , margin (px 10)
            , backgroundColor corzinha
            ]
        , onClick (Acender tipo)
        ]
        []



{-
   Essa é a view, ela gera HTML e Msg pro update.
   Note que ela não tem como alterar o model, somente o
   update pode alterar o model.
-}


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Sinal" ]
        , luz model green Verde
        , luz model yellow Amarelo
        , luz model red Vermelho
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { view = view >> toUnstyled
        , update = update
        , model = initialModel
        }
