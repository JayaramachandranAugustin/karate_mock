Feature: Book mock server

Background:
    * def books = {}
    * def uuid = function(){ return java.util.UUID.randomUUID() + ''}
    * configure responseHeaders = {'Content-Type':'application/json'}
    * configure cors = true
    * configure afterScenario = function(){ karate.set('responseDelay',200 + Math.random()* 400)}
    * def abortWithStatus =
    """
    function(status,data)
    {
        karate.set("responseStatus",status);
        karate.set("response",{content: data});
        karate.abort();
    }
    """
    


Scenario: pathMatches('/books') && methodIs('get')
    * def responseStatus = 200
    * def response = read('data/books.json')

Scenario: pathMatches('/book') && methodIs('get') && paramExists('name')
    * def content = 'Book title - ' + paramValue('name')
    * def responseStatus = 200
    * def responseDelay = 4000
    * def id = uuid()
    * def response = {id :'#(id)', content:'#(content)'}
 
Scenario: pathMatches('/book/{id}') && methodIs('get')
    * def result = books[pathParams.id]
    * eval if(!result) abortWithStatus(404,"book data not found")
    * def response = result

Scenario: pathMatches('/book') && methodIs('post') && !headerContains('Auth','secret')
    * print request
    * def book = request
    * def id = uuid()
    * book.id = id
    * books[id] = book
    * def response = book

Scenario: pathMatches('/book/{id}') && methodIs('delete')
    * def toDelete = books[pathParams.id]
    * eval if(!toDelete) abortWithStatus("500","book is already deleted or not found")
    * delete books[pathParams.id]
    * def responseStatus = 200
    * def response = toDelete

Scenario:
    * print request
    * def responseStatus = 404
    * def response = {content : "Not a valid url"}

