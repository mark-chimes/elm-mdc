module Demo.Tabs exposing (Model,defaultModel,Msg(Mdl),update,view,subscriptions)

import Dict exposing (Dict)
import Html exposing (..)
import Material
import Material.Options as Options exposing (styled, cs, css, when)
import Material.Tabs as TabBar
import Material.Toolbar as Toolbar
import Material.Typography as Typography
import Material.Theme as Theme
import Platform.Cmd exposing (Cmd, none)
import Demo.Page as Page exposing (Page)


-- MODEL


type alias Model =
    { mdl : Material.Model
    , examples : Dict Int Example
    }


type alias Example =
    { tab : Int
    }


defaultExample : Example
defaultExample =
    { tab = 0
    }


defaultModel : Model
defaultModel =
    { mdl = Material.defaultModel
    , examples = Dict.empty
    }


type Msg m
    = Mdl (Material.Msg m)
    | SelectTab Int Int


update : (Msg m -> m) -> Msg m -> Model -> ( Model, Cmd m )
update lift msg model =
    case msg of
        Mdl msg_ ->
            Material.update (Mdl >> lift) msg_ model

        SelectTab index tabIndex ->
            let
                example =
                    Dict.get index model.examples
                    |> Maybe.withDefault defaultExample
                    |> \example ->
                       { example | tab = tabIndex }
            in
            { model | examples = Dict.insert index example model.examples } ! []


view : (Msg m -> m) -> Page m -> Model -> Html m
view lift page model =
    page.body "Tabs"
    [
      Page.hero []
      [ heroTabs  lift model.mdl  0 (Dict.get  0 model.examples |> Maybe.withDefault defaultExample)
      ]
    ,
      example0  lift model.mdl  1 (Dict.get  1 model.examples |> Maybe.withDefault defaultExample)
    , example1  lift model.mdl  2 (Dict.get  2 model.examples |> Maybe.withDefault defaultExample)
    , example2  lift model.mdl  3 (Dict.get  3 model.examples |> Maybe.withDefault defaultExample)
    , example3  lift model.mdl  4 (Dict.get  4 model.examples |> Maybe.withDefault defaultExample)
    , example4  lift model.mdl  5 (Dict.get  5 model.examples |> Maybe.withDefault defaultExample)
    , example5  lift model.mdl  6 (Dict.get  6 model.examples |> Maybe.withDefault defaultExample)
    , example6  lift model.mdl  7 (Dict.get  7 model.examples |> Maybe.withDefault defaultExample)
    , example7  lift model.mdl  8 (Dict.get  8 model.examples |> Maybe.withDefault defaultExample)
    , example8  lift model.mdl  9 (Dict.get  9 model.examples |> Maybe.withDefault defaultExample)
    , example9  lift model.mdl 10 (Dict.get 10 model.examples |> Maybe.withDefault defaultExample)
    , example10 lift model.mdl 11 (Dict.get 11 model.examples |> Maybe.withDefault defaultExample)
    ]


heroTabs : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
heroTabs lift mdl index model =
    TabBar.render (Mdl >> lift) [index] mdl
    [ TabBar.indicator
    ]
    [ TabBar.tab [] [ text "Item One" ]
    , TabBar.tab [] [ text "Item Two" ]
    , TabBar.tab [] [ text "Item Three" ]
    ]


example0 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example0 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Basic Tab Bar"
        ]
      , heroTabs lift mdl index model
      ]
    ]


example1 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example1 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Tab Bar with Scroller"
        ]
      , TabBar.render (Mdl >> lift) [index] mdl
        [ TabBar.indicator
        , TabBar.scroller
        ]
        [ TabBar.tab [] [ text "Item One" ]
        , TabBar.tab [] [ text "Item Two" ]
        , TabBar.tab [] [ text "Item Three" ]
        , TabBar.tab [] [ text "Item Four" ]
        , TabBar.tab [] [ text "Item Five" ]
        , TabBar.tab [] [ text "Item Six" ]
        , TabBar.tab [] [ text "Item Seven" ]
        , TabBar.tab [] [ text "Item Eight" ]
        , TabBar.tab [] [ text "Item Nine" ]
        ]
      ]
    ]


example2 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example2 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Icon Tab Labels"
        ]
      , TabBar.render (Mdl >> lift) [index] mdl
        [ TabBar.indicator
        ]
        [ TabBar.tab [] [ TabBar.icon [] "phone" ]
        , TabBar.tab [] [ TabBar.icon [] "favorite" ]
        , TabBar.tab [] [ TabBar.icon [] "person_pin" ]
        ]
      ]
    ]


example3 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example3 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Icon Tab Labels"
        ]
      , TabBar.render (Mdl >> lift) [index] mdl
        [ TabBar.indicator
        ]
        [ TabBar.tab [ TabBar.withIconAndText ] [ TabBar.icon [] "phone", TabBar.iconLabel [] "Recents" ]
        , TabBar.tab [] [ TabBar.icon [] "favorite", TabBar.iconLabel [] "Favorites" ]
        , TabBar.tab [] [ TabBar.icon [] "person_pin", TabBar.iconLabel [] "Nearby" ]
        ]
      ]
    ]


example4 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example4 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
          [ text "Primary Color Indicator"
          ]
        , TabBar.render (Mdl >> lift) [index] mdl
          [ TabBar.indicator
          , TabBar.indicatorPrimary
          ]
          [ TabBar.tab [] [ text "Item One" ]
          , TabBar.tab [] [ text "Item Two" ]
          , TabBar.tab [] [ text "Item Three" ]
          ]
      ]
    ]


example5 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example5 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Accent Color Indicator"
        ]
      , TabBar.render (Mdl >> lift) [index] mdl
        [ TabBar.indicator
        , TabBar.indicatorAccent
        ]
        [ TabBar.tab [] [ text "Item One" ]
        , TabBar.tab [] [ text "Item Two" ]
        , TabBar.tab [] [ text "Item Three" ]
        ]
      ]
    ]


example6 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example6 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Within mdc-toolbar"
        ]
      , Toolbar.view (Mdl >> lift) [2*index] mdl
        [
        ]
        [ Toolbar.row []
          [ Toolbar.section
            [ Toolbar.alignStart
            ]
            [ Toolbar.title [] [ text "Title" ]
            ]
          , Toolbar.section
            [ Toolbar.alignEnd
            ]
            [ TabBar.render (Mdl >> lift) [2*index+1] mdl
              [ TabBar.indicator
              ]
              [ TabBar.tab [] [ text "Item One" ]
              , TabBar.tab [] [ text "Item Two" ]
              , TabBar.tab [] [ text "Item Three" ]
              ]
            ]
          ]
        ]
      ]
    ]


example7 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example7 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Within mdc-toolbar"
        ]
      , Toolbar.view (Mdl >> lift) [2*index] mdl
        [
        ]
        [ Toolbar.row []
          [ Toolbar.section
            [ Toolbar.alignStart
            ]
            [ Toolbar.title [] [ text "Title" ]
            ]
          , Toolbar.section
            [ Toolbar.alignEnd
            , css "position" "absolute"
            , css "right" "0"
            , css "bottom" "-16px"
            ]
            [ TabBar.render (Mdl >> lift) [2*index+1] mdl
              [
              ]
              [ TabBar.tab [] [ text "Item One" ]
              , TabBar.tab [] [ text "Item Two" ]
              , TabBar.tab [] [ text "Item Three" ]
              ]
            ]
          ]
        ]
      ]
    ]


example8 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example8 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Within mdc-toolbar + primary indicator"
        ]
      , Toolbar.view (Mdl >> lift) [2*index] mdl
        [ Theme.secondaryBg
        ]
        [ Toolbar.row []
          [ Toolbar.section
            [ Toolbar.alignStart
            ]
            [ Toolbar.title [] [ text "Title" ]
            ]
          , Toolbar.section
            [ Toolbar.alignEnd
            ]
            [ TabBar.render (Mdl >> lift) [2*index+1] mdl
              [ TabBar.indicator
              , TabBar.indicatorPrimary
              ]
              [ TabBar.tab [] [ text "Item One" ]
              , TabBar.tab [] [ text "Item Two" ]
              , TabBar.tab [] [ text "Item Three" ]
              ]
            ]
          ]
        ]
      ]
    ]


example9 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example9 lift mdl index model =
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Within mdc-toolbar + accent indicator"
        ]
      , Toolbar.view (Mdl >> lift) [2*index] mdl
        [ Theme.primaryBg
        ]
        [ Toolbar.row []
          [ Toolbar.section
            [ Toolbar.alignStart
            ]
            [ Toolbar.title [] [ text "Title" ]
            ]
          , Toolbar.section
            [ Toolbar.alignEnd
            ]
            [ TabBar.render (Mdl >> lift) [2*index+1] mdl
              [ TabBar.indicator
              , TabBar.indicatorAccent
              ]
              [ TabBar.tab [] [ text "Item One" ]
              , TabBar.tab [] [ text "Item Two" ]
              , TabBar.tab [] [ text "Item Three" ]
              ]
            ]
          ]
        ]
      ]
    ]


example10 : (Msg m -> m) -> Material.Model -> Int -> Example -> Html m
example10 lift mdl index model =
    let
        items =
            [ "Item One", "Item Two", "Item Three" ]
    in
    Html.section []
    [ fieldset []
      [ legend []
        [ text "Within Toolbar, Dynamic Content Control"
        ]
      , Toolbar.view (Mdl >> lift) [2*index] mdl
        [ Theme.primaryBg
        ]
        [ Toolbar.row []
          [ Toolbar.section
            [ Toolbar.alignEnd
            ]
            [ TabBar.render (Mdl >> lift) [2*index+1] mdl
              [ TabBar.indicator
              ]
              ( items
                |> List.indexedMap (\i label ->
                     TabBar.tab
                     [ Options.onClick (lift (SelectTab index i))
                     ]
                     [ text label
                     ]
                   )
              )
            ]
          ]
        ]
      , styled Html.section
        [ cs "panels"
        , css "padding" "8px"
        , css "border" "1px solid #ccc"
        , css "border-radius" "4px"
        , css "margin-top" "8px"
        ]
        ( [ "Item One"
          , "Item Two"
          , "Item Three"
          ]
          |> List.indexedMap (\i str ->
               let
                  isActive =
                      model.tab == i
               in
               styled Html.p
               [ cs "panel"
               , cs "active" |> when isActive
               , css "display" "none" |> when (not isActive)
               ]
               [ text str
               ]
             )
        )
      , styled Html.section
        [ cs "dots"
        , css "display" "flex"
        , css "justify-content" "flex-start"
        , css "margin-top" "4px"
        , css "padding-bottom" "16px"
        ]
        ( List.range 0 2
          |> List.map (\i ->
               let
                  isActive =
                      model.tab == i
               in
               styled Html.a
               [ cs "dot"
               , css "margin" "0 4px"
               , css "border-radius" "50%"
               , css "border" "1px solid #64DD17"
               , css "width" "20px"
               , css "height" "20px"
               , when isActive <|
                 Options.many
                 [ cs "active"
                 , css "background-color" "#64DD17"
                 , css "border-color" "#64DD17"
                 ]
               ]
               [
               ]
             )
        )
      ]
    ]


legend : List (Options.Style m) -> List (Html m) -> Html m
legend options =
    styled Html.legend
    ( css "display" "block"
    :: css "padding" "64px 16px 24px"
    :: Typography.title
    :: options
    )


fieldset : List (Options.Style m) -> List (Html m) -> Html m
fieldset options =
    styled Html.div
    ( css "display" "block"
    :: css "padding" "0 24px 16px"
    :: options
    )


subscriptions : (Msg m -> m) -> Model -> Sub m
subscriptions lift model =
    Material.subscriptions (Mdl >> lift) model
