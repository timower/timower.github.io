---
layout: page
title: Projects
permalink: /projects/
---

{% for project in site.projects %}
* [{{ project.title | escape }}]({{ project.url | relative_url }})
{% endfor %}