function BuildAnchor(args){

    var anchor = document.createElement("a")
    if("href" in args){
        anchor.href = anchor.href
    }

    if("className" in args){
        console.log(args.className)
        anchor.className = args.className
    }
    if("id" in args){
        anchor.id = args.id
    }
    if("type" in args){
        anchor.type = args.type
    }

    if("image" in args){
        var image = BuildImage(args.image)
        anchor.appendChild(image);
    }

    if("icon" in args){
        var icon = BuildIcon(args.icon)
        anchor.appendChild(icon);
    }

    if("onclick" in args){
    console.log(args.onclick.args)
        anchor.onclick=function(){window[args.onclick.function](args.onclick.args)};
    }
    return anchor
}

function BuildImage(args){

    var image = document.createElement("img")
    if("className" in args){
        image.className = args.className
    }
    if("src" in args){
        image.src = args.src
    }
    return image
}

function BuildIcon(args){
    var icon = document.createElement("i");
    console.log(args)
    if("className" in args){
        icon.className = args.className
    }
    if("style" in args){
        icon.style = args.style
    }

    return icon
}

function BuildParagraph(args){
    var paragraph = document.createElement("p");
    if("className" in args){
        paragraph.className = args.className;
    }
    if("innerText" in args){
        paragraph.innerText = args.innerText;
    }

    return paragraph
}