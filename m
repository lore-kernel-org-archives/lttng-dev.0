From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [documentation] Drawing: LTTng trace session in
 relation to commandline options
Date: Tue, 27 May 2014 13:50:26 -0400
Message-ID: <5384D062.70109__18956.7188885578$1401213092$gmane$org@voxpopuli.im>
References: <48CF5AC71E61DB46B70D0F388054EFFD359AE808@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <CANq1AQqq5j7165a3sQkcVvidd0DsX+4C17DApiF5uD0OS=k+tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1801761458=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WpLW7-0002cZ-L5
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 13:50:33 -0400
In-Reply-To: <CANq1AQqq5j7165a3sQkcVvidd0DsX+4C17DApiF5uD0OS=k+tg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Randy Wijnants <dev@tty32.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1801761458==
Content-Type: multipart/alternative;
 boundary="------------000205070301000701060108"

This is a multi-part message in MIME format.
--------------000205070301000701060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id s4RHox1M019870

Nice work! These kind of high-level diagrams can be really helpful to=20
new users.

Just a side-note wouldn't it be interesting to also carry the original=20
(inkscape?) file in the git tree? That way if we want to make changes or=20
additions we don't have to start over.

Cheers,
Alexandre


On 05/27/2014 01:40 PM, Randy Wijnants wrote:
> Excelent! Used all of your improved syntaxes. Simplified /
> restructured enable-event a
> bit so that this is more readable in the drawing.
>
> Also added lttng relayd / snapshot syntaxes.
>
> Changed "Kernelspace specific" into "Kernel specific".
>
> Added footnotes.
>
> Excuse me for the SVG problem. I created this in google docs. I didn't
> assume google's way of exporting SVGs was so poor, i have the same issu=
e
> using inkscape.
> If i have time i will migrate it manually to inkscape. That might indee=
d
> explain the misalignment issue you described.
>
> Let me know what you think : )
>
> http://tty32.org/Trace%20session.png
>
>
> Greetings,
> Randy Wijnants.
> "The good part about UDP jokes is that i don't have to worry if you get=
 it
> or not"
>
>
> On 27 May 2014 17:19, Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca=
>wrote:
>
>> ----------------------------------------------------------------------
>> Date: Tue, 27 May 2014 13:34:20 +0200
>> From: Randy Wijnants <dev@tty32.org>
>>
>>> In addition to the LTTng architecture diagram, I've drawn a diagram t=
hat
>> shows the relation between the command line options and how to configu=
re a
>> trace session.
>>> I hope it proves to be useful, if you have any suggestions let me kno=
w!
>>>
>>> Originally posted on IRC. As suggested by Compudj i've released it un=
der
>> CC license.
>>> http://tty32.org/Trace%20session.png
>>> http://tty32.org/Trace%20session.svg
>>>
>>> Randy Wijnants.
>> ----------------------------------------------------------------------
>>
>>     Neither the png nor svg versions line up correctly the text and
>> coloured boxes with each other.  This may be a local rendering issue. =
 At
>> least the svg version has a proper white background (my png renders wi=
th a
>> very dark grey background, making it very hard to make out some of the
>> text).  However, the svg version is unusable because none of the text =
is
>> text: everything is svg:path with opaque d attributes (this may explai=
n the
>> alignment problems).
>>
>>     Here are improved (more accurate) expressions for the various comm=
and
>> syntaxes:
>>
>> $ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH |
>> --set-url URL | --no-output] [--snapshot]
>>     (the ctrl-url etc. options are in pre-emption order)
>>
>> $ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...]
>> [--discard | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM]
>> [--switch-timer USEC] [--read-timer USEC] \
>>
>>                                        [--output (mmap | splice)]
>> [--buffers-uid | --buffers-pid | --buffers-global] [--tracefile-size S=
IZE
>> [--tracefile-count COUNT]]
>>
>> $ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--al=
l
>> [--tracepoint | --syscall] | \
>>                                              NAME[,NAME2,...] [--trace=
point
>> [(--loglevel | --loglevel-only) LOGLEVEL] [--filter 'EXPRESSION'] |
>> (--probe | --function) (addr | symbol | symbol+offset)])
>>
>> $ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--typ=
e
>> TYPE)+
>>
>> $ lttng list (-k | -u)
>>     (not the full syntax, but rather the syntax that will get just a l=
ist
>> of event names)
>>
>> $ lttng add-context --help
>>     (the only one that doesn't change!)
>>
>>     Change "Kernelspace specific" into "Kernel specific".
>>
>>     Add footnotes:
>> * --session NAME defaults to the current session
>> * --channel NAME in the enable-event case defaults to 'channel0', but =
only
>> if the domain is virgin
>> * --channel NAME in the add-context case defaults to all channels
>>
>> Daniel U. Thibault
>> Protection des syst=E8mes et contremesures (PSC) | Systems Protection =
&
>> Countermeasures (SPC)
>> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Crit=
ical
>> Cyber Security (MCCS)
>> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defenc=
e R&D
>> Canada - Valcartier (DRDC Valcartier)
>> 2459 route de la Bravoure
>> Qu=E9bec QC  G3J 1X5
>> CANADA
>> Vox : (418) 844-4000 x4245
>> Fax : (418) 844-4538
>> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
>> Gouvernement du Canada | Government of Canada
>> <http://www.valcartier.drdc-rddc.gc.ca/>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------000205070301000701060108
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Nice work! These kind of high-level diagrams can be really helpful
    to new users.<br>
    <br>
    Just a side-note wouldn't it be interesting to also carry the
    original (inkscape?) file in the git tree? That way if we want to
    make changes or additions we don't have to start over.<br>
    <br>
    Cheers,<br>
    Alexandre<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 05/27/2014 01:40 PM, Randy Wijnants
      wrote:<br>
    </div>
    <blockquote
cite="mid:CANq1AQqq5j7165a3sQkcVvidd0DsX+4C17DApiF5uD0OS=k+tg@mail.gmail.com"
      type="cite">
      <pre wrap="">Excelent! Used all of your improved syntaxes. Simplified /
restructured enable-event a
bit so that this is more readable in the drawing.

Also added lttng relayd / snapshot syntaxes.

Changed "Kernelspace specific" into "Kernel specific".

Added footnotes.

Excuse me for the SVG problem. I created this in google docs. I didn't
assume google's way of exporting SVGs was so poor, i have the same issue
using inkscape.
If i have time i will migrate it manually to inkscape. That might indeed
explain the misalignment issue you described.

Let me know what you think : )

<a class="moz-txt-link-freetext" href="http://tty32.org/Trace%20session.png">http://tty32.org/Trace%20session.png</a>


Greetings,
Randy Wijnants.
"The good part about UDP jokes is that i don't have to worry if you get it
or not"


On 27 May 2014 17:19, Thibault, Daniel <a class="moz-txt-link-rfc2396E" href="mailto:Daniel.Thibault@drdc-rddc.gc.ca">&lt;Daniel.Thibault@drdc-rddc.gc.ca&gt;</a>wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">----------------------------------------------------------------------
Date: Tue, 27 May 2014 13:34:20 +0200
From: Randy Wijnants <a class="moz-txt-link-rfc2396E" href="mailto:dev@tty32.org">&lt;dev@tty32.org&gt;</a>

</pre>
        <blockquote type="cite">
          <pre wrap="">In addition to the LTTng architecture diagram, I've drawn a diagram that
</pre>
        </blockquote>
        <pre wrap="">shows the relation between the command line options and how to configure a
trace session.
</pre>
        <blockquote type="cite">
          <pre wrap="">I hope it proves to be useful, if you have any suggestions let me know!

Originally posted on IRC. As suggested by Compudj i've released it under
</pre>
        </blockquote>
        <pre wrap="">CC license.
</pre>
        <blockquote type="cite">
          <pre wrap="">
<a class="moz-txt-link-freetext" href="http://tty32.org/Trace%20session.png">http://tty32.org/Trace%20session.png</a>
<a class="moz-txt-link-freetext" href="http://tty32.org/Trace%20session.svg">http://tty32.org/Trace%20session.svg</a>

Randy Wijnants.
</pre>
        </blockquote>
        <pre wrap="">----------------------------------------------------------------------

   Neither the png nor svg versions line up correctly the text and
coloured boxes with each other.  This may be a local rendering issue.  At
least the svg version has a proper white background (my png renders with a
very dark grey background, making it very hard to make out some of the
text).  However, the svg version is unusable because none of the text is
text: everything is svg:path with opaque d attributes (this may explain the
alignment problems).

   Here are improved (more accurate) expressions for the various command
syntaxes:

$ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH |
--set-url URL | --no-output] [--snapshot]
   (the ctrl-url etc. options are in pre-emption order)

$ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...]
[--discard | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM]
[--switch-timer USEC] [--read-timer USEC] \

                                      [--output (mmap | splice)]
[--buffers-uid | --buffers-pid | --buffers-global] [--tracefile-size SIZE
[--tracefile-count COUNT]]

$ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--all
[--tracepoint | --syscall] | \
                                            NAME[,NAME2,...] [--tracepoint
[(--loglevel | --loglevel-only) LOGLEVEL] [--filter 'EXPRESSION'] |
(--probe | --function) (addr | symbol | symbol+offset)])

$ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type
TYPE)+

$ lttng list (-k | -u)
   (not the full syntax, but rather the syntax that will get just a list
of event names)

$ lttng add-context --help
   (the only one that doesn't change!)

   Change "Kernelspace specific" into "Kernel specific".

   Add footnotes:
* --session NAME defaults to the current session
* --channel NAME in the enable-event case defaults to 'channel0', but only
if the domain is virgin
* --channel NAME in the add-context case defaults to all channels

Daniel U. Thibault
Protection des syst&egrave;mes et contremesures (PSC) | Systems Protection &amp;
Countermeasures (SPC)
Cyber s&eacute;curit&eacute; pour les missions essentielles (CME) | Mission Critical
Cyber Security (MCCS)
R &amp; D pour la d&eacute;fense Canada - Valcartier (RDDC Valcartier) | Defence R&amp;D
Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu&eacute;bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <a class="moz-txt-link-rfc2396E" href="http://www.travelgis.com/map.asp?addr=918V%20QSDJ">&lt;http://www.travelgis.com/map.asp?addr=918V%20QSDJ&gt;</a>
Gouvernement du Canada | Government of Canada
<a class="moz-txt-link-rfc2396E" href="http://www.valcartier.drdc-rddc.gc.ca/">&lt;http://www.valcartier.drdc-rddc.gc.ca/&gt;</a>

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000205070301000701060108--


--===============1801761458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1801761458==--
