From: Ganesh Sangle <ganesh@portworx.com>
Subject: reading text files created by babeltrace
Date: Thu, 22 Oct 2015 13:02:20 -0700
Message-ID: <CAAkbhRyUOxf63_TGFtdk4P-U-ovJHbipAENJF-PXKqN4Pmg1rg__15713.223469402$1445547039$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319698318=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ganesh@portworx.com>) id 1ZpM4A-0005iQ-RY
 for lttng-dev@lists.lttng.org; Thu, 22 Oct 2015 16:02:31 -0400
Received: by lfaz124 with SMTP id z124so61038046lfa.1
 for <lttng-dev@lists.lttng.org>; Thu, 22 Oct 2015 13:02:20 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0319698318==
Content-Type: multipart/alternative; boundary=001a11401ff6010e5f0522b6f9c0

--001a11401ff6010e5f0522b6f9c0
Content-Type: text/plain; charset=UTF-8

I am trying to use the babeltrace lib to read a trace file. So here it the
flow: 1. babeltrace /var/log/some_trace > trc.txt 2. My program does this
in trying to add a trace after creating context:

code
int err = bt_context_add_trace(ctx, path, "text", nullptr,
    nullptr, nullptr);
code


   1. Compile and Run the program gives this error: code [error] [Context]
   Format "text" unknown. code

The idea is that i have trace generated on multiple machines - and though I
can read use my program to directly read the binary trace files on my local
system, for other systems, i convert the trace using babeltrace and then
process all these traces together.

The package i have installed is this: babeltrace-devel-1.2.4-1.el7.x86_64


http://stackoverflow.com/questions/33289656/babeltrace-format-text-unknown

-- 
-ganesh

--001a11401ff6010e5f0522b6f9c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font=
-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,=
sans-serif;line-height:19px">I am trying to use the babeltrace lib to read =
a trace file. So here it the flow: 1. babeltrace /var/log/some_trace &gt; t=
rc.txt 2. My program does this in trying to add a trace after creating cont=
ext:</p><pre style=3D"margin-top:0px;padding:5px;border:0px;font-size:13px;=
overflow:auto;width:auto;max-height:600px;background-color:rgb(238,238,238)=
;font-family:Consolas,Menlo,Monaco,&#39;Lucida Console&#39;,&#39;Liberation=
 Mono&#39;,&#39;DejaVu Sans Mono&#39;,&#39;Bitstream Vera Sans Mono&#39;,&#=
39;Courier New&#39;,monospace,sans-serif;word-wrap:normal"><code style=3D"m=
argin:0px;padding:0px;border:0px;font-family:Consolas,Menlo,Monaco,&#39;Luc=
ida Console&#39;,&#39;Liberation Mono&#39;,&#39;DejaVu Sans Mono&#39;,&#39;=
Bitstream Vera Sans Mono&#39;,&#39;Courier New&#39;,monospace,sans-serif;wh=
ite-space:inherit">code
int err =3D bt_context_add_trace(ctx, path, &quot;text&quot;, nullptr,
    nullptr, nullptr);
code
</code></pre><ol start=3D"3" style=3D"margin:0px 0px 1em 30px;padding:0px;b=
order:0px;font-size:15px;list-style-position:initial;font-family:&#39;Helve=
tica Neue&#39;,Helvetica,Arial,sans-serif;line-height:19px"><li style=3D"ma=
rgin:0px 0px 0.5em;padding:0px;border:0px;word-wrap:break-word">Compile and=
 Run the program gives this error: code [error] [Context] Format &quot;text=
&quot; unknown. code</li></ol><p style=3D"margin:0px 0px 1em;padding:0px;bo=
rder:0px;font-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Hel=
vetica,Arial,sans-serif;line-height:19px">The idea is that i have trace gen=
erated on multiple machines - and though I can read use my program to direc=
tly read the binary trace files on my local system, for other systems, i co=
nvert the trace using babeltrace and then process all these traces together=
.</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;font-size:15px;c=
lear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;l=
ine-height:19px">The package i have installed is this: babeltrace-devel-1.2=
.4-1.el7.x86_64</p><p style=3D"margin:0px 0px 1em;padding:0px;border:0px;fo=
nt-size:15px;clear:both;font-family:&#39;Helvetica Neue&#39;,Helvetica,Aria=
l,sans-serif;line-height:19px"><br></p><p style=3D"margin:0px 0px 1em;paddi=
ng:0px;border:0px;font-size:15px;clear:both;font-family:&#39;Helvetica Neue=
&#39;,Helvetica,Arial,sans-serif;line-height:19px"><a href=3D"http://stacko=
verflow.com/questions/33289656/babeltrace-format-text-unknown">http://stack=
overflow.com/questions/33289656/babeltrace-format-text-unknown</a>=C2=A0<br=
></p><div><br></div>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr">=
-ganesh</div></div>
</div>

--001a11401ff6010e5f0522b6f9c0--


--===============0319698318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0319698318==--
