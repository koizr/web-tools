import { Elm } from "./Main.elm";
import Clipboard from "clipboard";

Elm.Main.init({
  node: document.querySelector("main")
});

new Clipboard("[data-copy-to-clipboard]");
