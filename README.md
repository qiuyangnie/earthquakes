# earthquakes

## Aim:
The goal of this data visualisation is to use of computer-supported, visual representations of data to amplify cognition.

## Methods:
The process for developing a visualisation, has seven stages from acquiring data to interacting with it according to Ben(2008).

![Seven stages for data visualisation](https://github.com/qiuyangnie/earthquakes/blob/master/img/seven_stages_ben.jpg)

## The Data:
The data is from the [US Geological Survey websites][link] about active earthquakes around the world. The data is available in a variety of formats. 

The example of a partial extract from the CSV formatted version is:

![An example of partial extract from the CSV formatted version](https://github.com/qiuyangnie/earthquakes/blob/master/img/csv_extract.jpg=800px)

Then parsing the relevant parts of each record to present the data in a visual form. For example, the parsing process requires to read each line as a String, split this String into pieces and convert each piece to the correct type of value. Then using these values to present the data in an appropriate way. 

### Working with CSV Data in Processing:
A CSV file is a text file in which certain characters must be interpreted as delimiters. There are two structures in a CSV file, a record, which is a line of text and a field which is a part of a record. A record is an individual line from the CSV file and a field is a part of the line. To identify fields in a record a special character (a comma) is used.

To convert a CSV file to a usable internal format must convert records in the CSV file to a data structure. A class is defined to represent the record.

The first step is to read in the CSV file. As the CSV file is a text file and each record is a line of text, the Processing function loadStrings() can be used. Next the required fields from each line need to be parsed and extracted. The fields extracted must be parsed to convert them from text to the required data type (e.g. latitude and longitude should be numbers). Once the required fields are extracted and parsed the values can be used to construct an object to represent the record.

## Design and Implementation:
The earthquake data contains geographic references so a good visualisation would start with mapping the location of the earthquakes onto a map of the world.

Using a geo-graphic (equi-rectangular) projection of the earth, which allows to map longitude and latitude to Cartesian co-ordinates without needing a complex transform function as the map projection already has accounted for the distortion introduced when going from a spherical to a flat surface (i.e. we distort the map not the transform).

![Implementation](https://github.com/qiuyangnie/earthquakes/blob/master/img/p08.jpg=900px)

## Iterative Design and Implementation:
### Working with JSON Data in Processing
From a programming perspective, a better or more readable and maintainable way to parse the data is to refer to the required parts by name and not by position like the first implementation. Therefore, working with data in JSON form allows a key to be associated with a data item. Once the key is known, the data can be accessed regardless of its position. The US Geological Survey also publish the data in JSON format, such as GeoJSON object.

![GeoJSON object](https://github.com/qiuyangnie/earthquakes/blob/master/img/GeoJSON.jpg=900px)
![Iterative Implementation](https://github.com/qiuyangnie/earthquakes/blob/master/img/p09.jpg=900px)

## Future Development:
Usually there is a cleaning step, to ensure missing and incorrect data will not cause problems for the application. and this data cleaning step can be an important element of all data visualisation (or analysis) tasks and should not be underestimated. In this prototype the makeSplitFriendly() function addresses some of this data cleaning activity, but in general it is a large part of any data analysis work.

    [link]: https://earthquake.usgs.gov/earthquakes/
