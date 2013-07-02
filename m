From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: New LTTNG user
Date: Tue, 2 Jul 2013 14:42:37 -0400
Message-ID: <51D31F1D.9020105__576.392879202281$1372790626$gmane$org@ericsson.com>
References: <CAPxN80A4-Fa3hhA8+zmmckhwRrp0qb2+xXcebw8tmB1QXGULzw@mail.gmail.com>
	<CAPxN80BrtX4Y7RT-O9FUc72TWj-9Oh7MtzbteoRNaMqwgEZB1Q@mail.gmail.com>
	<51CC65DD.8040804@ericsson.com>
	<CAPxN80D7K-DXgxNcPOFrfmpOeEvL0q-sELmsUR8gF_8MWd2yfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0194752506=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1Uu5Xl-0001YD-Ly
	for lttng-dev@lists.lttng.org; Tue, 02 Jul 2013 14:43:13 -0400
In-Reply-To: <CAPxN80D7K-DXgxNcPOFrfmpOeEvL0q-sELmsUR8gF_8MWd2yfg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0194752506==
Content-Type: multipart/alternative;
	boundary="------------020005040509090003090901"

--------------020005040509090003090901
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Jessica,

I am ccing the list because this is relevant and I am hoping someone
yells at me: "No you're wrong!" It's a great way to learn.
On 13-06-28 03:33 PM, Jessica Foest wrote:
> hi Matthew,
> thanks for your response
>
> i'm using ubuntu distribution.
> your solution seems to be a good one but i'm not sure that i
> understand what do you mean by "check later events to infer if enabled
> is true" , can your explain to me how can i do it ?

Ok, you can do it in may ways technically, also I am far from being an
expert on the subject of promiscuity, you may want to consult with
people in security for less  

let's say you have the following events

file_read, net_set_promiscuous, file_read, file_write,
net_copy_whole_packet_to_cpu, file_touch

these are obviously made up events, but it's to give you an idea of
what's going on.

you know the mode is set when net_set_promiscuous is called, you don't
know if it's changed or not, someone can be calling true or false
constantly.
you know that net_copy_whole_packet_to_cpu is only callable when the
card is in promiscuous mode.
let's say there's a second set promiscous mode and nothing saying before
that the card was in promiscuous mode, could it be safe to assume that
it was not?

When you get the second packet, you know the mode.

function receive_event(event event_){
  if( event.is_promiscuous() == true) {
    flags.new_promiscuous_mode = true;
    flags.new_promiscuous_time = event.ts;
  }
  if( event.is_an_event_that_will_only_happen_in_promiscuous_mode() ) {
    if( flags.new_promiscuous_mode == true) {
     flags.new_promiscuous_mode = false;
     flags.promiscuous = true;
    }
  }
}

This is by the way one of the interesting use cases of the state systems
available in eclipse and the awesome LTTv. You read the trace once,
infer more information then the analysis tools will give you pertinent
info, instead of sifting through a detailed events list like this
http://youtu.be/3vAnuBtyEYE.

best regards,

Matthew

>
> regards
>
>
> 2013/6/27 Matthew Khouzam <matthew.khouzam@ericsson.com
> <mailto:matthew.khouzam@ericsson.com>>
>
>     Hi,
>
>     Welcome to LTTng-dev.
>
>     What distro are you using?
>
>     I am looking at the tracepoints, I see system tap has
>     probe:netdev.set_promiscuity, it's probably not in the default
>     list but it hooked onto set_promiscuity.
>
>     Maybe you can use a kprobe on set_promiscuity and then check later
>     events to infer if enabled is true. I'm sorry, I work more on the
>     trace viewing side than the kernel side so my knowledge is rather
>     limited.
>
>     Hope this helps and please keep us updated, this is an interesting
>     problem.
>
>     Matthew
>
>
>     On 13-06-26 04:14 PM, Jessica Foest wrote:
>>     Hi
>>
>>     when use lttng network tracepoint it didn't display network
>>     interface mode (like promiscuous mode or other ) . did i miss
>>     some tracepoint option or it's a limitation ?
>>     regard
>>
>>
>>     2013/6/26 Jessica Foest <jessica.foest@gmail.com
>>     <mailto:jessica.foest@gmail.com>>
>>
>>         Hi
>>
>>         when use lttng network tracepoint it didn't display network
>>         interface mode (like promiscuous mode or other ) . did i miss
>>         some tracepoint option or it's a limitation ?
>>         regard
>>
>>
>>
>>
>>     _______________________________________________
>>     lttng-dev mailing list
>>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>>     http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--------------020005040509090003090901
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi Jessica, <br>
    <br>
    I am ccing the list because this is relevant and I am hoping someone
    yells at me: "No you're wrong!" It's a great way to learn. <br>
    <div class="moz-cite-prefix">On 13-06-28 03:33 PM, Jessica Foest
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAPxN80D7K-DXgxNcPOFrfmpOeEvL0q-sELmsUR8gF_8MWd2yfg@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div dir="ltr">
        <div>
          <div>
            <div>
              <div>hi Matthew,<br>
              </div>
              <div>thanks for your response <br>
              </div>
              <div><br>
              </div>
              i'm using ubuntu distribution.<br>
            </div>
            your solution seems to be a good one but i'm not sure that i
            understand what do you mean by <tt>"check later events to
              infer if enabled is true" , can your explain to me how can
              i do it ? <br>
            </tt></div>
        </div>
      </div>
    </blockquote>
    <br>
    <tt>Ok, you can do it in may ways technically, also I am far from
      being an expert on the subject of promiscuity, you may want to
      consult with people in security for less &nbsp; <br>
      <br>
      let's say you have the following events<br>
      <br>
      file_read, net_set_promiscuous, file_read, file_write,
      net_copy_whole_packet_to_cpu, file_touch<br>
      <br>
      these are obviously made up events, but it's to give you an idea
      of what's going on. <br>
      <br>
      you know the mode is set when net_set_promiscuous is called, you
      don't know if it's changed or not, someone can be calling true or
      false constantly. <br>
      you know that net_copy_whole_packet_to_cpu is only callable when
      the card is in promiscuous mode.<br>
      let's say there's a second set promiscous mode and nothing saying
      before that the card was in promiscuous mode, could it be safe to
      assume that it was not? <br>
      <br>
      When you get the second packet, you know the mode. <br>
      <br>
      function receive_event(event event_){<br>
      &nbsp; if( event.is_promiscuous() == true) {<br>
      &nbsp;&nbsp;&nbsp; flags.new_promiscuous_mode = true; <br>
    </tt><tt><tt>&nbsp;&nbsp;&nbsp; flags.new_promiscuous_time = event.ts;<br>
        &nbsp; </tt>
      }<br>
      &nbsp; if(
      event.is_an_event_that_will_only_happen_in_promiscuous_mode() ) {<br>
      &nbsp;&nbsp;&nbsp; if( </tt><tt><tt>flags.new_promiscuous_mode == true) {<br>
        &nbsp;</tt></tt><tt><tt><tt>&nbsp;&nbsp;&nbsp; flags.new_promiscuous_mode = false;<br>
          &nbsp;&nbsp;&nbsp;&nbsp; flags.promiscuous = true;<br>
          &nbsp;&nbsp;&nbsp; }<br>
          &nbsp; </tt></tt>}<br>
      }</tt><br>
    <br>
    This is by the way one of the interesting use cases of the state
    systems available in eclipse and the awesome LTTv. You read the
    trace once, infer more information then the analysis tools will give
    you pertinent info, instead of sifting through a detailed events
    list like this <a class="moz-txt-link-freetext" href="http://youtu.be/3vAnuBtyEYE">http://youtu.be/3vAnuBtyEYE</a>. <br>
    <br>
    best regards, <br>
    <br>
    Matthew<br>
    <br>
    <blockquote
cite="mid:CAPxN80D7K-DXgxNcPOFrfmpOeEvL0q-sELmsUR8gF_8MWd2yfg@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div><tt><br>
            </tt></div>
          <tt>regards<br>
          </tt></div>
      </div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">2013/6/27 Matthew Khouzam <span
            dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:matthew.khouzam@ericsson.com" target="_blank">matthew.khouzam@ericsson.com</a>&gt;</span><br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="#FFFFFF" text="#000000"> <tt>Hi, <br>
                <br>
                Welcome to LTTng-dev.<br>
              </tt><br>
              <tt><tt>What distro are you using? <br>
                  <br>
                </tt>I am looking at the tracepoints, I see system tap
                has probe:netdev.set_promiscuity, it's probably not in
                the default list but it hooked onto set_promiscuity.<br>
                <br>
                Maybe you can use a kprobe on set_promiscuity and then
                check later events to infer if enabled is true. I'm
                sorry, I work more on the trace viewing side than the
                kernel side so my knowledge is rather limited. <br>
                <br>
                Hope this helps and please keep us updated, this is an
                interesting problem.<span class="HOEnZb"><font
                    color="#888888"><br>
                    <br>
                    Matthew<br>
                    <br>
                    <br>
                  </font></span></tt>
              <div>
                <div class="h5">
                  <div>On 13-06-26 04:14 PM, Jessica Foest wrote:<br>
                  </div>
                </div>
              </div>
              <blockquote type="cite">
                <div>
                  <div class="h5">
                    <div dir="ltr">
                      <div>
                        <div>
                          <div>Hi<br>
                            <br>
                            when use lttng network tracepoint it didn't
                            display network interface mode (like
                            promiscuous mode or other ) . did i miss
                            some tracepoint option or it's a limitation
                            ?<br>
                          </div>
                        </div>
                      </div>
                      regard</div>
                    <div class="gmail_extra"><br>
                      <br>
                      <div class="gmail_quote">2013/6/26 Jessica Foest <span
                          dir="ltr">&lt;<a moz-do-not-send="true"
                            href="mailto:jessica.foest@gmail.com"
                            target="_blank">jessica.foest@gmail.com</a>&gt;</span><br>
                        <blockquote class="gmail_quote" style="margin:0
                          0 0 .8ex;border-left:1px #ccc
                          solid;padding-left:1ex">
                          <div dir="ltr">
                            <div>
                              <div>
                                <div>Hi<br>
                                  <br>
                                  when use lttng network tracepoint it
                                  didn't display network interface mode
                                  (like promiscuous mode or other ) .
                                  did i miss some tracepoint option or
                                  it's a limitation ?<br>
                                </div>
                              </div>
                            </div>
                            regard<br>
                          </div>
                        </blockquote>
                      </div>
                      <br>
                    </div>
                    <br>
                    <fieldset></fieldset>
                    <br>
                  </div>
                </div>
                <div class="im">
                  <pre>_______________________________________________
lttng-dev mailing list
<a moz-do-not-send="true" href="mailto:lttng-dev@lists.lttng.org" target="_blank">lttng-dev@lists.lttng.org</a>
<a moz-do-not-send="true" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target="_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
                </div>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------020005040509090003090901--


--===============0194752506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0194752506==--
