window.onload = function() {
	var clearButton = document.getElementById('clearButton');
	var backgroundColorButton = document.getElementById('backgroundColorButton');
	var gridSizeButton = document.getElementById('gridSizeButton');
	var gridCheckbox = document.getElementById('gridCheckbox');
	var randomColorButton = document.getElementById('randomColorButton');
	var colorfullButton = document.getElementById('colorfullButton');
	var gradualButton = document.getElementById('gradualButton');
	var containerDiv = document.getElementById('container');
	
	function createGridContainerDiv() {
		var gridContainer = document.createElement('div');
		gridContainer.id = "gridContainer";
		gridContainer.style.border = "2px solid red";
		gridContainer.style.width = "720px";
		gridContainer.style.height = "720px";
		containerDiv.appendChild(gridContainer);
	};

	var tileSize = 8.0085;
	function createGrid(numberOfTiles, background) {
		createGridContainerDiv();
		for (i = 1; i <= numberOfTiles * numberOfTiles; i++) {
			var tile = document.createElement('div');
			tile.className = "tile";
			tileSize = 720 / numberOfTiles;
			tile.style.height = tileSize + "px";
			tile.style.width = tileSize + "px";
			tile.style.display = "inline-block";
			tile.style.float = "right";
			tile.style.backgroundColor = "purple";
			gridContainer.appendChild(tile);
		}
	}
	createGrid(50, "purple");
	var mouseOnTileColor = "pink";
	var defaultColor = 255;
	var mouseLeftTileColor = "rgb(" + 255 + "," + 255 + "," + 255 + ")";
	var buttonSelected = "";

	function randomColor() {
		function rand() {return Math.floor(Math.random() * 256)};
		return "rgb(" + rand() + "," + rand() + "," + rand() + ")";
	};

	function backgroundColor(color) {
		$(".tile").css("background-color", color);
	};

	function hovering() {
		$(".tile").mouseenter(function() {
			switch (buttonSelected) {
				case "randomColor":
					$(this).css("background-color", mouseOnTileColor)
					break;
				case "colorfull":
					$(this).css("background-color", randomColor());
					break;
				case "gradual":
					var gradCurrent = parseInt(this.style.backgroundColor.slice(4,7));
					var gradSet = "rgb(" + (gradCurrent - 26) + "," + (gradCurrent - 26) + "," + (gradCurrent - 26) + ")";
					$(this).css("background-color", gradSet);
					break;
				default:
					$(this).css("background-color", mouseOnTileColor)
			};	
		});

		$(".tile").mouseleave(function() {
			switch (buttonSelected) {
				case "randomColor":
					$(this).css("background-color", mouseLeftTileColor);
					break;
				case "colorfull":
					break;
				case "gradual":
					break;
				default:
					mouseLeftTileColor = "rgb(" + defaultColor + "," + defaultColor + "," + defaultColor + ")";
					$(this).css("background-color", mouseLeftTileColor);
			};
		});
	};
	hovering();

	clearButton.onclick = function() {
		backgroundColor("purple");
	};

	gridSizeButton.onclick = function() {
		var promptGridSize = prompt("Choose a number between 16-100", "90");
		if (promptGridSize !== null) {
			document.getElementById("gridContainer").remove();
			createGrid(promptGridSize, "purple");
		};
		hovering();
	};

	backgroundColorButton.onclick = function() {
		var promptColor = prompt("What color? (e.g., blue, rgb(0,0,255), #0000FF", "purple");
		backgroundColor(promptColor)
	}

	gridCheckbox.onclick = function() {
		if (gridCheckbox.checked === true) {
			$(".tile").height(tileSize - 2 + "px");
			$(".tile").width(tileSize - 2 + "px");
			$(".tile").css("border","1px dotted rgb(160,0,200)");
		} else {
			$(".tile").height(tileSize + "px");
			$(".tile").width(tileSize + "px");
			$(".tile").css("border","none");
		}
	};
	
	randomColorButton.onclick = function() {
		buttonSelected = "randomColor";
		mouseOnTileColor = randomColor();
		mouseLeftTileColor = randomColor();
	};

	colorfullButton.onclick = function() {
		buttonSelected = "colorfull";
	};

	gradualButton.onclick = function() {
		$(".tile").css("background-color", "rgb(255,255,255)");
		buttonSelected = "gradual";
	};
};