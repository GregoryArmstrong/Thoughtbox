$(document).ready(function(){
  queryAllLinks();
});

function queryAllLinks(){
  $.ajax({
    url: "/links",
    type: "GET",
    dataType: "json",
    success: function(response){
      console.log('success all links', response);
      createLinkElements(response);
    },
    error: function(xhr){
      console.log('fail all links', xhr);
    }
  });
}

function createLinkElements(links) {
  var formatted_links = links.map(function(link){
    return formatLink(link);
  });
  $('.links-list').append(formatted_links.join(" "));
  setAJAXPutListener();
}

function formatLink(link){
  return ("<li link_id='" + link.id + "'>" +
          "<h2>" + link.url + "</h2>" +
          "<h3>" + link.title + "</h3>" +
          "<h3><a href='/links/" + link.id + "/edit'>Edit</a>" +
          formatReadOrUnread(link) +
          "</li>");
}

function formatReadOrUnread(link){
  if (link.read) {
    return "<h3 class='mark_unread' id='" + link.id + "' switch=true>Mark as Unread</h3>";
  } else {
    return "<h3 class='mark_read' id='" + link.id + "' switch=true>Mark as Read</h3>";
  }
}

function setAJAXPutListener(){
  $('.mark_unread, .mark_read').click(function() {
    var link_url = "/links/" + this.id;
    var toggle = this.attributes.switch.value;
    var dataHandle = { toggle: toggle };
    $.ajax({
      url: link_url,
      type: "PUT",
      data: dataHandle,
      dataType: "json",
      success: function(response) {
        console.log('successful update', response);
        recycleLinks();
      },
      error: function(xhr) {
        console.log('fail update', xhr);
        recycleLinks();
      }
    });
  });
}

function recycleLinks(){
  $('li').remove();
  queryAllLinks();
}
