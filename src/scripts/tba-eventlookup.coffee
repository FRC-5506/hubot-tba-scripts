# Description:
#   Allows for the lookup of different events
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot eventlookup <eventcode> - Looks up the specified event code and returns info on the event
#
# Author:
#   nh_99

module.exports = (robot) ->

  robot.respond /eventlookup (.*)/i, (msg) ->
    eventToSearch = msg.match[1]
    robot.logger.info eventToSearch
    robot.http('http://www.thebluealliance.com/api/v2/event/' + eventToSearch)
      .header('X-TBA-App-Id', 'frc5506:hubot-tba-scripts:v0.1')
      .get() (err, res, body) ->
        data = JSON.parse body
        message = '*Results for ' + data.name + '*\n'
        message += '*Location:* ' + data.venue_address + '\n' if data.venue_address
        message += '*Website:* ' + data.website if data.website
        message += '*Start Date:* ' + data.start_date if data.start_date
        msg.send(message)