From: Randy Wijnants <dev@tty32.org>
Subject: Re: [documentation] Drawing: LTTng trace session in
 relation to commandline options
Date: Wed, 28 May 2014 13:46:35 +0200
Message-ID: <CANq1AQp7-AX3E89U-rjAMyvryqvwuN_k5STbna1G9JPPv6S4EQ__11067.6201679327$1401277658$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938139706=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <randy@tty32.org>) id 1WpcJd-0000nT-Ea
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 07:46:42 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so16806762qgd.5
 for <lttng-dev@lists.lttng.org>; Wed, 28 May 2014 04:46:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1938139706==
Content-Type: multipart/alternative; boundary=001a11c139ba54007a04fa745df2

--001a11c139ba54007a04fa745df2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

That's great to hear!

I was also about to suggest that, but unfortunately google docs doesn't
export SVGs very well. For example text is exported as paths and not as
text elements. Also some misalignment issues as you can see in the graphic.
If i have time left i will convert it manually to usable SVG file. Maybe
for now push it to the repo as it is?

Updated version:
http://tty32.org/Trace%20session.png
http://tty32.org/Trace%20session.svg

Greetings,
Randy Wijnants.
"The good part about UDP jokes is that i don't have to worry if you get it
or not"


On 27 May 2014 19:50, Alexandre Montplaisir <alexmonthy@voxpopuli.im> wrote=
:

>  Nice work! These kind of high-level diagrams can be really helpful to ne=
w
> users.
>
> Just a side-note wouldn't it be interesting to also carry the original
> (inkscape?) file in the git tree? That way if we want to make changes or
> additions we don't have to start over.
>
> Cheers,
> Alexandre
>
>
>
> On 05/27/2014 01:40 PM, Randy Wijnants wrote:
>
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
> assume google's way of exporting SVGs was so poor, i have the same issue
> using inkscape.
> If i have time i will migrate it manually to inkscape. That might indeed
> explain the misalignment issue you described.
>
> Let me know what you think : )
> http://tty32.org/Trace%20session.png
>
>
> Greetings,
> Randy Wijnants.
> "The good part about UDP jokes is that i don't have to worry if you get i=
t
> or not"
>
>
> On 27 May 2014 17:19, Thibault, Daniel <Daniel.Thibault@drdc-rddc.gc.ca> =
<Daniel.Thibault@drdc-rddc.gc.ca>wrote:
>
>
>  ----------------------------------------------------------------------
> Date: Tue, 27 May 2014 13:34:20 +0200
> From: Randy Wijnants <dev@tty32.org> <dev@tty32.org>
>
>  In addition to the LTTng architecture diagram, I've drawn a diagram that
>
>  shows the relation between the command line options and how to configure=
 a
> trace session.
>
>  I hope it proves to be useful, if you have any suggestions let me know!
>
> Originally posted on IRC. As suggested by Compudj i've released it under
>
>  CC license.
>
>  http://tty32.org/Trace%20session.pnghttp://tty32.org/Trace%20session.svg
>
> Randy Wijnants.
>
>  ----------------------------------------------------------------------
>
>    Neither the png nor svg versions line up correctly the text and
> coloured boxes with each other.  This may be a local rendering issue.  At
> least the svg version has a proper white background (my png renders with =
a
> very dark grey background, making it very hard to make out some of the
> text).  However, the svg version is unusable because none of the text is
> text: everything is svg:path with opaque d attributes (this may explain t=
he
> alignment problems).
>
>    Here are improved (more accurate) expressions for the various command
> syntaxes:
>
> $ lttng create [NAME] [--ctrl-url URL --data-url URL | --output PATH |
> --set-url URL | --no-output] [--snapshot]
>    (the ctrl-url etc. options are in pre-emption order)
>
> $ lttng enable-channel (-k | -u) [--session NAME] NAME[,NAME2,...]
> [--discard | --overwrite] [--subbuf-size SIZE] [--num-subbuf NUM]
> [--switch-timer USEC] [--read-timer USEC] \
>
>                                       [--output (mmap | splice)]
> [--buffers-uid | --buffers-pid | --buffers-global] [--tracefile-size SIZE
> [--tracefile-count COUNT]]
>
> $ lttng enable-event (-k | -u) [--session NAME] [--channel NAME] (--all
> [--tracepoint | --syscall] | \
>                                             NAME[,NAME2,...] [--tracepoin=
t
> [(--loglevel | --loglevel-only) LOGLEVEL] [--filter 'EXPRESSION'] |
> (--probe | --function) (addr | symbol | symbol+offset)])
>
> $ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type
> TYPE)+
>
> $ lttng list (-k | -u)
>    (not the full syntax, but rather the syntax that will get just a list
> of event names)
>
> $ lttng add-context --help
>    (the only one that doesn't change!)
>
>    Change "Kernelspace specific" into "Kernel specific".
>
>    Add footnotes:
> * --session NAME defaults to the current session
> * --channel NAME in the enable-event case defaults to 'channel0', but onl=
y
> if the domain is virgin
> * --channel NAME in the add-context case defaults to all channels
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> R & D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defenc=
e R&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ> <ht=
tp://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada<http://www.valcartier.drdc-=
rddc.gc.ca/> <http://www.valcartier.drdc-rddc.gc.ca/>
>
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev
>
>
>

--001a11c139ba54007a04fa745df2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s great to hear!<div><br></div><div>I was also ab=
out to suggest that, but unfortunately google docs doesn&#39;t export SVGs =
very well. For example text is exported as paths and not as text elements. =
Also some misalignment issues as you can see in the graphic.</div>
<div>If i have time left i will convert it manually to usable SVG file. May=
be for now push it to the repo as it is?</div><div><br></div><div>Updated v=
ersion:</div><div><a href=3D"http://tty32.org/Trace%20session.png">http://t=
ty32.org/Trace%20session.png</a><br>
</div><div><a href=3D"http://tty32.org/Trace%20session.svg">http://tty32.or=
g/Trace%20session.svg</a><br></div><div class=3D"gmail_extra"><br clear=3D"=
all"><div><div dir=3D"ltr"><div>Greetings,</div><div>Randy Wijnants.<br></d=
iv><div>
&quot;The good part about UDP jokes is that i don&#39;t have to worry if yo=
u get it or not&quot;</div></div></div>
<br><br><div class=3D"gmail_quote">On 27 May 2014 19:50, Alexandre Montplai=
sir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.im" target=
=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x">

 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    Nice work! These kind of high-level diagrams can be really helpful
    to new users.<br>
    <br>
    Just a side-note wouldn&#39;t it be interesting to also carry the
    original (inkscape?) file in the git tree? That way if we want to
    make changes or additions we don&#39;t have to start over.<br>
    <br>
    Cheers,<br>
    Alexandre<div><div class=3D"h5"><br>
    <br>
    <br>
    <div>On 05/27/2014 01:40 PM, Randy Wijnants
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
      <pre>Excelent! Used all of your improved syntaxes. Simplified /
restructured enable-event a
bit so that this is more readable in the drawing.

Also added lttng relayd / snapshot syntaxes.

Changed &quot;Kernelspace specific&quot; into &quot;Kernel specific&quot;.

Added footnotes.

Excuse me for the SVG problem. I created this in google docs. I didn&#39;t
assume google&#39;s way of exporting SVGs was so poor, i have the same issu=
e
using inkscape.
If i have time i will migrate it manually to inkscape. That might indeed
explain the misalignment issue you described.

Let me know what you think : )

<a href=3D"http://tty32.org/Trace%20session.png" target=3D"_blank">http://t=
ty32.org/Trace%20session.png</a>


Greetings,
Randy Wijnants.
&quot;The good part about UDP jokes is that i don&#39;t have to worry if yo=
u get it
or not&quot;


On 27 May 2014 17:19, Thibault, Daniel <a href=3D"mailto:Daniel.Thibault@dr=
dc-rddc.gc.ca" target=3D"_blank">&lt;Daniel.Thibault@drdc-rddc.gc.ca&gt;</a=
>wrote:

</pre>
      <blockquote type=3D"cite">
        <pre>--------------------------------------------------------------=
--------
Date: Tue, 27 May 2014 13:34:20 +0200
From: Randy Wijnants <a href=3D"mailto:dev@tty32.org" target=3D"_blank">&lt=
;dev@tty32.org&gt;</a>

</pre>
        <blockquote type=3D"cite">
          <pre>In addition to the LTTng architecture diagram, I&#39;ve draw=
n a diagram that
</pre>
        </blockquote>
        <pre>shows the relation between the command line options and how to=
 configure a
trace session.
</pre>
        <blockquote type=3D"cite">
          <pre>I hope it proves to be useful, if you have any suggestions l=
et me know!

Originally posted on IRC. As suggested by Compudj i&#39;ve released it unde=
r
</pre>
        </blockquote>
        <pre>CC license.
</pre>
        <blockquote type=3D"cite">
          <pre><a href=3D"http://tty32.org/Trace%20session.png" target=3D"_=
blank">http://tty32.org/Trace%20session.png</a>
<a href=3D"http://tty32.org/Trace%20session.svg" target=3D"_blank">http://t=
ty32.org/Trace%20session.svg</a>

Randy Wijnants.
</pre>
        </blockquote>
        <pre>--------------------------------------------------------------=
--------

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
[(--loglevel | --loglevel-only) LOGLEVEL] [--filter &#39;EXPRESSION&#39;] |
(--probe | --function) (addr | symbol | symbol+offset)])

$ lttng add-context (-k | -u) [--session NAME] [--channel NAME] (--type
TYPE)+

$ lttng list (-k | -u)
   (not the full syntax, but rather the syntax that will get just a list
of event names)

$ lttng add-context --help
   (the only one that doesn&#39;t change!)

   Change &quot;Kernelspace specific&quot; into &quot;Kernel specific&quot;=
.

   Add footnotes:
* --session NAME defaults to the current session
* --channel NAME in the enable-event case defaults to &#39;channel0&#39;, b=
ut only
if the domain is virgin
* --channel NAME in the add-context case defaults to all channels

Daniel U. Thibault
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp;
Countermeasures (SPC)
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical
Cyber Security (MCCS)
R &amp; D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&amp;D
Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=C3=A9bec QC  G3J 1X5
CANADA
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000" t=
arget=3D"_blank">(418) 844-4000 x4245</a>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538" target=3D=
"_blank">(418) 844-4538</a>
NAC : 918V QSDJ <a href=3D"http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ" target=3D"_blank">&lt;http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ&gt;</a>
Gouvernement du Canada | Government of Canada
<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">&lt;ht=
tp://www.valcartier.drdc-rddc.gc.ca/&gt;</a>

</pre>
      </blockquote>
      <pre></pre>
      <br>
      <fieldset></fieldset>
      <br>
      </div></div><pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br></div></div>

--001a11c139ba54007a04fa745df2--


--===============1938139706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1938139706==--
