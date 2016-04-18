$(document).ready(function(){
  queryAllLinks();
  $('#search_field').keyup(searchLinkElements);
  $('.sort-read-unread').click(function(){
    sortReadUnread();
  });
  $('.show-all').click(function(){
    showAll();
  });
});

function showAll(){
  var links = $('.link-item').toArray();
  links.forEach(function(link){
    link.style.display="inline";
  });
}

function sortReadUnread(){
  var reads = $('.mark_read').parent().toArray();
  reads.forEach(function(parent){
    if (parent.style.display == 'none') {
      parent.style.display="inline";
    } else {
      parent.style.display="none";
    }
  });
  var unreads = $('.mark_unread').parent().toArray();
  unreads.forEach(function(parent){
    if (parent.style.display == 'inline') {
      parent.style.display="none";
    } else {
      parent.style.display="inline";
    }
  });
}

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
  return ("<li link_id='" + link.id + "' class='link-item'>" +
          "<h2 class='link-item-url'>" + link.url + "</h2>" +
          "<h3 class='link-item-title'>" + link.title + "</h3>" +
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

function searchLinkElements(){
  var search_term = $('#search_field').val();
  matchSearch(search_term);
}

function matchSearch(term){
  var link_items = $('.link-item').toArray();
  link_items.forEach(function(link){
    var children = $(link).children().toArray();
    url = $(children[0]).text();
    title = $(children[1]).text();
    hideItem(term, link, url, title);
    showItem(term, link, url, title);
  });
}

function hideItem(search_term, link, url, title){
    if (url.indexOf(search_term) == -1) {
    link.style.display="none";
  } else if (title.indexOf(search_term) == -1) {
    link.style.display="none";
  }
}

function showItem(search_term, link, url, title){
  if (url.indexOf(search_term) !== -1) {
    link.style.display="inline";
  } else if (title.indexOf(search_term) !== -1) {
    link.style.display="inline";
  }
}
