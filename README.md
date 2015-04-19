# Github Markdowns

a quick brown fox `jumps` over the lazy dog

## Link

https://avatars0.githubusercontent.com/u/5117479?v=3&s=460

## Strikethrough

~~Mistaken text.~~

## Image

![a photo](https://avatars0.githubusercontent.com/u/5117479?v=3&s=460)
![a photo](https://avatars0.githubusercontent.com/u/5117479?v=3&s=460)
![a photo](https://avatars0.githubusercontent.com/u/5117479?v=3&s=460)

## List

1. item
2. item
    - item
    - item
        * item
        * item
    - item
3. item

## code

Here's an example:

```
function test() {
  console.log("notice the blank line before this function?");
}
```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

## tables

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

---

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |

---

| Name | Description          |
| ------------- | ----------- |
| Help      | ~~Display the~~ help window.|
| Close     | _Closes_ a window     |


# heading 1
## heading 2
### heading 3
#### heading 4
##### heading 5
###### heading 6


> a
> b
> c
> d
> e

*Hello* **World**
_Hello_ __World__
_Hello_ *__World__*