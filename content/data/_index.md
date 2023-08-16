---
title: Data
type: landing

---
<font size= “3”> All data is available in preprocesed Seurat Objects from <a href="https://zenodo.org/record/7754315">Zenodo</a>

Below are plots from these processed datasets emphasizing ADT expression for each ADT as well as ATAC coverage, RNA expression and chromVAR scores if applicable.

<head>
    <title>Dropdown Menu Example</title>
  <style>
        #selected-image {
            max-width: 800px;
            max-height: 800px;
        }
    </style>
</head>
<body>
    <label for="category">Select a dataset:</label>
    <select id="category">
        <optgroup label="Brain Organoids">
            <option value="SOX2">SOX2</option>
            <option value="GLI3">GLI3</option>
            <option value="TBR1">TBR1</option>
        </optgroup>
        <optgroup label="Retinal Organoids">
            <option value="SOX2">SOX2</option>
            <option value="SOX9">SOX9</option>
            <option value="YAP1">YAP1</option>
        </optgroup>
        <optgroup label="Cell Lines">
            <option value="SOX2">SOX2</option>
            <option value="OCT4">OCT4</option>
            <option value="GATA1">GATA1</option>
        </optgroup>
    </select>
    <br>
    <img id="selected-image" src="" alt="Selected Image">
    <script>
        const categoryDropdown = document.getElementById('category');
        const selectedImage = document.getElementById('selected-image');

        categoryDropdown.addEventListener('change', function() {
            const selectedValue = categoryDropdown.value;
            selectedImage.src = getImageSource(selectedValue);
        });

        function getImageSource(value) {
            switch (value) {
                case 'SOX2':
                    return 'SOX2.png'; // Replace with your image file path
                case 'GLI3':
                    return 'GLI3.png'; // Replace with your image file path
                case 'TBR1':
                    return 'TBR1.png'; // Replace with your image file path
                default:
                    return ''; // No image for other values
            }
        }
    </script>
</body>
</html>

