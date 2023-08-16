---
title: Data
type: landing

---
<!DOCTYPE html>
<html>
<head>
    <title>Dropdown Menu Example</title>
</head>
<body>
    <label for="category">Select a dataset:</label>
    <select id="category">
        <option value="" selected disabled>Select an antibody</option>
        <option value="SOX2">SOX2</option>
        <option value="GLI3">GLI3</option>
    </select>
    <br>
    <img id="selected-image" src="" alt="Selected Image">
    <script>
        const categoryDropdown = document.getElementById('category');
        const selectedImage = document.getElementById('selected-image');

        categoryDropdown.addEventListener('change', function() {
            const selectedValue = categoryDropdown.value;
            selectedImage.src = `${selectedValue.toLowerCase()}.png`;
        });
    </script>
</body>
</html>



<img src="SOX2.png" alt="kit" width="600"/>