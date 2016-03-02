From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Segfault during process exit
Date: Wed, 2 Mar 2016 15:35:07 -0500
Message-ID: <56D74E7B.3090901__21825.004896573$1456950975$gmane$org@efficios.com>
References: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
 <56D73D48.3070700@efficios.com>
 <DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1044210844=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1abDUJ-0004Wa-96
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 15:35:16 -0500
In-Reply-To: <DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@live.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1044210844==
Content-Type: multipart/alternative;
 boundary="------------010801030003090508040907"

This is a multi-part message in MIME format.
--------------010801030003090508040907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Don't forget to cc the mailing list.

On 2016-03-02 02:42 PM, Jeffrey Chen wrote:
>
> Even I share our executable, you will not be able to run on your 
> machine, as it depends on our environment.
>
This is expected, it's also why I asked you if you could provide a 
reproducer, a simpler version of your problem that reproduce the 
behavior even sporadically.

> The idea is that, if you spawn some threads, and these threads keep 
> writing traces through LTTng. Then, exit the main thread, as in return 
> main() function. LTTng's logic will do cleanup itself, but my other 
> threads are still writing to LTTng. This would cause segfault. It 
> would try to reference address 0x0.
>
This could be a good start for a simple reproducer.

Cheers
>
>
> #0 0x0000000000000000 in ?? ()
> #1  0x00007f7e31fdfd78 in __tracepoint_cb_processor___tracepoint_info (
>     taskNameArg=0x1cf3c30 "BackgroundTask", dataArg=0x1fd5200 "S")
>
> ...
>
> ------------------------------------------------------------------------
> *From:* Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
> *Sent:* Wednesday, March 2, 2016 11:21 AM
> *To:* Jeffrey Chen
> *Cc:* lttng-dev@lists.lttng.org
> *Subject:* Re: [lttng-dev] Segfault during process exit
> Hi,
>
> Could you provide a reproducer ?
>
> Could you give us some context ?
>
> Thanks
>
> On 2016-03-02 02:07 PM, Jeffrey Chen wrote:
>>
>> Hi:
>>
>>
>> Our system process will spawn several background threads to do tasks. 
>> During the process exit, there is no guarantee that these background 
>> threads are finished. I have noticed several times that the execution 
>> would segfault during exiting. The stacktrace is showing that the 
>> segfault happened at the call to write trace, tracepoint(). My guess 
>> is that LTTng cleaned up the tracing connection, and the background 
>> thread was still running. Has anyone noticed this issue? I thought 
>> about trying wait for all the background threads to complete, but 
>> this is very difficult to do in a complex system, as the background 
>> thread could spawn more threads during the process. Is there any way 
>> to solve this? Thanks.
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> -- 
> Jonathan R. Julien
> Efficios

-- 
Jonathan R. Julien
Efficios


--------------010801030003090508040907
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hi,<br>
    <br>
    Don't forget to cc the mailing list.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 2016-03-02 02:42 PM, Jeffrey Chen
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top=
:0;margin-bottom:0;} --></style>
    </blockquote>
    <blockquote
cite=3D"mid:DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
        <p> Even I share our executable, you will not be able to run on
          your machine, as it depends on our environment.</p>
      </div>
    </blockquote>
    This is expected, it's also why I asked you if you could provide a
    reproducer, a simpler version of your problem that reproduce the
    behavior even sporadically.<br>
    <br>
    <blockquote
cite=3D"mid:DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
        <p>The idea is that, if you spawn some threads, and these
          threads keep writing traces through LTTng. Then, exit the main
          thread, as in return main() function. LTTng's logic will do
          cleanup itself, but my other threads are still writing to
          LTTng. This would cause segfault. It would try to reference
          address 0x0.<br>
        </p>
      </div>
    </blockquote>
    This could be a good start for a simple reproducer. <br>
    <br>
    Cheers<br>
    <blockquote
cite=3D"mid:DM3PR13MB0782CC28E9FE90AA3B35B8E9C7BC0@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
        <p>
        </p>
        <p><br>
        </p>
        <p><span style=3D"background-color: rgb(255, 255, 0);">#0=C2=A0
            0x0000000000000000 in ?? ()</span><br>
          #1=C2=A0 0x00007f7e31fdfd78 in
          __tracepoint_cb_processor___tracepoint_info (<br>
          =C2=A0=C2=A0=C2=A0 taskNameArg=3D0x1cf3c30 "BackgroundTask", da=
taArg=3D0x1fd5200
          "S")<br>
        </p>
        ...<br>
        <br>
        <div style=3D"color: rgb(0, 0, 0);">
          <hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
          <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:=
11pt"
              face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b>
              Jonathan Rajotte Julien
              <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Jonathan.=
rajotte-julien@efficios.com">&lt;Jonathan.rajotte-julien@efficios.com&gt;=
</a><br>
              <b>Sent:</b> Wednesday, March 2, 2016 11:21 AM<br>
              <b>To:</b> Jeffrey Chen<br>
              <b>Cc:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"ma=
ilto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
              <b>Subject:</b> Re: [lttng-dev] Segfault during process
              exit</font>
            <div>=C2=A0</div>
          </div>
          <div>Hi,<br>
            <br>
            Could you provide a reproducer ?<br>
            <br>
            Could you give us some context ?<br>
            <br>
            Thanks<br>
            <br>
            <div class=3D"moz-cite-prefix">On 2016-03-02 02:07 PM, Jeffre=
y
              Chen wrote:<br>
            </div>
            <blockquote type=3D"cite">
              <div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;
                color:#000000; background-color:#FFFFFF;
                font-family:Calibri,Arial,Helvetica,sans-serif">
                <p>Hi:</p>
                <p><br>
                </p>
                <p>Our system process will spawn several background
                  threads to do tasks. During the process exit, there is
                  no guarantee that these background threads are
                  finished. I have noticed several times that the
                  execution would segfault during exiting. The
                  stacktrace is showing that the segfault happened at
                  the call to write trace, tracepoint(). My guess is
                  that LTTng cleaned up the tracing connection, and the
                  background thread was still running. Has anyone
                  noticed this issue?=C2=A0I thought about trying wait fo=
r
                  all the background threads to complete, but this is
                  very difficult to do in a complex system, as the
                  background thread could spawn more threads during the
                  process. Is there any way to solve this? Thanks.<br>
                </p>
              </div>
              <br>
              <fieldset class=3D"mimeAttachmentHeader"></fieldset>
              <br>
              <pre>_______________________________________________
lttng-dev mailing list
<a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated" href=3D"ma=
ilto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a moz-do-not-send=3D"true" title=3D"Ctrl+Click or tap to follow the link=
" class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev</a>
</pre>
            </blockquote>
            <br>
            <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------010801030003090508040907--


--===============1044210844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1044210844==--
