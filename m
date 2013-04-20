From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: lttng-tools-2.1.1 for linux-3.4.3
Date: Fri, 19 Apr 2013 21:33:02 -0400
Message-ID: <CA+umk=rwcRV40vVAXm1ftS2XFPCK8=PQcTLgniboWrbhZUWcuw__36033.7405968041$1366421619$gmane$org@mail.gmail.com>
References: <05E83BDD0E1F054FA73F00F6970F05C606310B@CH1PRD0810MB394.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1260743462=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1UTMfs-000406-29
	for lttng-dev@lists.lttng.org; Fri, 19 Apr 2013 21:33:08 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so106754pbc.17
	for <lttng-dev@lists.lttng.org>; Fri, 19 Apr 2013 18:33:02 -0700 (PDT)
In-Reply-To: <05E83BDD0E1F054FA73F00F6970F05C606310B@CH1PRD0810MB394.namprd08.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1260743462==
Content-Type: multipart/alternative; boundary=047d7b6d7a72032ba704dac0d190

--047d7b6d7a72032ba704dac0d190
Content-Type: text/plain; charset=ISO-8859-1

Forgot to forward to mailing list again;



Hey Hari,

While working on porting LTTng to Android, we did fall on similar problems
regarding undefined low level kernel functions; these all seemed to be very
platform-specific, and in this case you'll most likely find the calls you
need in your platform's include/endian.h or include/sys/endian.h header
files (most likely under slightly different names).

On our end, we ended up 'patching' these problems by adding config
verifications for the missing functions, and when those failed we simply
redefined them in-code via #define macros using whatever was defined in the
platform headers.

In any case, we'll be sending our patches in for review soon, but for now,
I hope this leads you somwhere.

-PL


On Fri, Apr 19, 2013 at 8:34 PM, Hari Prasad Kalavakunta <
Hari.Prasad@radisys.com> wrote:

>  Hello lttng-dev,****
>
> ** **
>
> Bison version upgrade to 2.4 took care of the earlier blocker. ****
>
> ** **
>
> Undefined references to htobe64 and htobe32 are thrown. Could you please
> direct me if this is known one.****
>
> ** **
>
> ../../../src/common/.libs/libconsumer.a(consumer.o): In function
> `write_relayd_metadata_id':****
>
> /root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1290: undefined
> reference to `htobe64'****
>
> /root/lttng2.1/lttng-tools-2.1.1/src/common/consumer.c:1291: undefined
> reference to `htobe32'****
>
> ** **
>
> Regards,****
>
> Hari****
>
> ** **
>
> *From:* Hari Prasad Kalavakunta
> *Sent:* Friday, April 19, 2013 9:18 PM
> *To:* lttng-dev@lists.lttng.org
> *Subject:* lttng-tools-2.1.1 for linux-3.4.3****
>
> ** **
>
> Hello lttng-dev,****
>
> ** **
>
> When cross compiling lttng-tools-2.1.1 for PowerPC-32 bit, I am running
> into few issues. Could you please let me know what is wrong here.****
>
> ** **
>
> First, there was a problem using EPOLL feature.****
>
> ** **
>
> $ CFLAGS="-m32 -g -O2" ./configure --prefix=/home/xxx/linux-3.4.3/
> --host=powerpc-linux****
>
> $ make****
>
> ** **
>
> make[3]: Entering directory
> `/home/xxx/lttng2.1/lttng-tools-2.1.1/src/common/compat'****
>
>   CC     compat-epoll.lo****
>
> In file included from compat-epoll.c:31:****
>
> poll.h:76: error: 'EPOLL_CLOEXEC' undeclared here (not in a function)****
>
> ** **
>
> ** **
>
> To go past this problem, I have chosen not to use EPOLL through
> ax_have_epoll_cppflags flag****
>
> ** **
>
> $ export ax_cv_have_epoll =no****
>
> $ CFLAGS="-m32 -g -O2" ./configure --prefix=/home/xxx/linux-3.4.3/
> --host=powerpc-linux****
>
> $ make****
>
> ** **
>
> YACC   filter-parser.c****
>
> /home/xxx/lttng2.1/lttng-tools-2.1.1/src/lib/lttng-ctl/filter/filter-parser.y:299.9-16:
> syntax error, unexpected identifier, expecting string****
>
> ** **
>
> ** **
>
> This time parser appears have some kind of issue. Also, there are few
> warnings as shown below that indicates to me that configure is not done in
> the correct way.****
>
> consumer.c: In function 'write_relayd_stream_header':****
>
> consumer.c:749: warning: implicit declaration of function 'htobe64'****
>
> consumer.c:750: warning: implicit declaration of function 'htobe32'****
>
> ** **
>
> Could you please let me know what could be wrong here. Your help is
> appreciated. Except of lttng-tools, all other components have be
> successfully build and installed.****
>
> ** **
>
> Regards,****
>
> Hari****
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--047d7b6d7a72032ba704dac0d190
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Forgot to forward to mailing list again;<div><br></div><di=
v><br></div><div><br><div><span style=3D"font-family:arial,sans-serif;font-=
size:12.800000190734863px">Hey Hari,</span><div style=3D"font-family:arial,=
sans-serif;font-size:12.800000190734863px">
<br></div><div style=3D"font-family:arial,sans-serif;font-size:12.800000190=
734863px">While working on porting LTTng to Android, we did fall on similar=
 problems regarding undefined low level kernel functions; these all seemed =
to be very platform-specific, and in this case you&#39;ll most likely find =
the calls you need in your platform&#39;s include/endian.h or include/sys/e=
ndian.h header files (most likely under slightly different names).</div>
<div style=3D"font-family:arial,sans-serif;font-size:12.800000190734863px">=
<br></div><div style=3D"font-family:arial,sans-serif;font-size:12.800000190=
734863px">On our end, we ended up &#39;patching&#39; these problems by addi=
ng config verifications for the missing functions, and when those failed we=
 simply redefined them in-code via #define macros using whatever was define=
d in the platform headers.</div>
<div style=3D"font-family:arial,sans-serif;font-size:12.800000190734863px">=
<br></div><div style=3D"font-family:arial,sans-serif;font-size:12.800000190=
734863px">In any case, we&#39;ll be sending our patches in for review soon,=
 but for now, I hope this leads you somwhere.</div>
<div style=3D"font-family:arial,sans-serif;font-size:12.800000190734863px">=
<br></div><div style=3D"font-family:arial,sans-serif;font-size:12.800000190=
734863px">-PL</div></div></div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">
On Fri, Apr 19, 2013 at 8:34 PM, Hari Prasad Kalavakunta <span dir=3D"ltr">=
&lt;<a href=3D"mailto:Hari.Prasad@radisys.com" target=3D"_blank">Hari.Prasa=
d@radisys.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">






<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D""><span style=3D"color:rgb(31,73,125)">Hello lttng-dev,<u></u><=
u></u></span></p>
<p class=3D""><span style=3D"color:rgb(31,73,125)"><u></u>=A0<u></u></span>=
</p>
<p class=3D""><span style=3D"color:rgb(31,73,125)">Bison version upgrade to=
 2.4 took care of the earlier blocker.
<u></u><u></u></span></p>
<p class=3D""><span style=3D"color:rgb(31,73,125)"><u></u>=A0<u></u></span>=
</p>
<p class=3D""><span style=3D"font-family:&#39;Courier New&#39;">Undefined r=
eferences to htobe64 and htobe32 are thrown. Could you please direct me if =
this is known one.<span style=3D"color:rgb(31,73,125)"><u></u><u></u></span=
></span></p>

<p class=3D""><span style=3D"font-family:&#39;Courier New&#39;;color:rgb(31=
,73,125)"><u></u>=A0<u></u></span></p>
<p class=3D""><span style=3D"font-family:&#39;Courier New&#39;">../../../sr=
c/common/.libs/libconsumer.a(consumer.o): In function `write_relayd_metadat=
a_id&#39;:<u></u><u></u></span></p>
<p class=3D""><span style=3D"font-family:&#39;Courier New&#39;">/root/lttng=
2.1/lttng-tools-2.1.1/src/common/consumer.c:1290: undefined reference to `h=
tobe64&#39;<u></u><u></u></span></p>
<p class=3D""><span style=3D"font-family:&#39;Courier New&#39;">/root/lttng=
2.1/lttng-tools-2.1.1/src/common/consumer.c:1291: undefined reference to `h=
tobe32&#39;<u></u><u></u></span></p>
<p class=3D""><span style=3D"color:rgb(31,73,125)"><u></u>=A0<u></u></span>=
</p>
<p class=3D""><span style=3D"color:rgb(31,73,125)">Regards,<u></u><u></u></=
span></p>
<p class=3D""><span style=3D"color:rgb(31,73,125)">Hari<u></u><u></u></span=
></p>
<p class=3D""><span style=3D"color:rgb(31,73,125)"><u></u>=A0<u></u></span>=
</p>
<div>
<div style=3D"border-style:solid none none;border-top-color:rgb(181,196,223=
);border-top-width:1pt;padding:3pt 0in 0in">
<p class=3D""><b><span style=3D"font-size:10pt;font-family:Tahoma,sans-seri=
f">From:</span></b><span style=3D"font-size:10pt;font-family:Tahoma,sans-se=
rif"> Hari Prasad Kalavakunta
<br>
<b>Sent:</b> Friday, April 19, 2013 9:18 PM<br>
<b>To:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a><br>
<b>Subject:</b> lttng-tools-2.1.1 for linux-3.4.3<u></u><u></u></span></p>
</div>
</div><div class=3D"im">
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">Hello lttng-dev,<u></u><u></u></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">When cross compiling lttng-tools-2.1.1 for PowerPC-32 bit, I =
am running into few issues. Could you please let me know what is wrong here=
.<u></u><u></u></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">First, there was a problem using EPOLL feature.<u></u><u></u>=
</p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"" style=3D"margin-left:0.5in">$ CFLAGS=3D&quot;-m32 -g -O2&quot=
; ./configure --prefix=3D/home/xxx/linux-3.4.3/ --host=3Dpowerpc-linux<u></=
u><u></u></p>
<p class=3D"" style=3D"margin-left:0.5in">$ make<u></u><u></u></p>
<p class=3D"" style=3D"margin-left:0.5in"><u></u>=A0<u></u></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">make[3]: Entering directory `/home/xxx/lttng2.1/lttng-tools-=
2.1.1/src/common/compat&#39;<u></u><u></u></span></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">=A0 CC=A0=A0=A0=A0 compat-epoll.lo<u></u><u></u></span></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">In file included from compat-epoll.c:31:<u></u><u></u></span=
></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">poll.h:76: error: &#39;EPOLL_CLOEXEC&#39; undeclared here (n=
ot in a function)<u></u><u></u></span></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">To go past this problem, I have chosen not to use EPOLL throu=
gh ax_have_epoll_cppflags flag<u></u><u></u></p>
<p class=3D""><u></u>=A0<u></u></p>
</div><p class=3D"" style=3D"margin-left:0.5in">$ export ax_<span style=3D"=
color:rgb(31,73,125)">cv</span>_<span style=3D"color:rgb(31,73,125)">have_<=
/span>epoll =3Dno<u></u><u></u></p><div class=3D"im">
<p class=3D"" style=3D"margin-left:0.5in">$ CFLAGS=3D&quot;-m32 -g -O2&quot=
; ./configure --prefix=3D/home/xxx/linux-3.4.3/ --host=3Dpowerpc-linux<u></=
u><u></u></p>
<p class=3D"" style=3D"margin-left:0.5in">$ make<u></u><u></u></p>
<p class=3D"" style=3D"margin-left:0.5in"><u></u>=A0<u></u></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">YACC=A0=A0 filter-parser.c<u></u><u></u></span></p>
<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;">/home/xxx/lttng2.1/lttng-tools-2.1.1/src/lib/lttng-ctl/filte=
r/filter-parser.y:299.9-16: syntax error, unexpected identifier, expecting =
string<u></u><u></u></span></p>

<p class=3D"" style=3D"margin-left:1in"><span style=3D"font-family:&#39;Cou=
rier New&#39;"><u></u>=A0<u></u></span></p>
<p class=3D"" style=3D"margin-left:0.5in"><span style=3D"font-family:&#39;C=
ourier New&#39;"><u></u>=A0<u></u></span></p>
<p class=3D"">This time parser appears have some kind of issue. Also, there=
 are few warnings as shown below that indicates to me that configure is not=
 done in the correct way.<u></u><u></u></p>
<p class=3D"" style=3D"margin-left:0.5in"><span style=3D"font-family:&#39;C=
ourier New&#39;">consumer.c: In function &#39;write_relayd_stream_header&#3=
9;:<u></u><u></u></span></p>
<p class=3D"" style=3D"margin-left:0.5in"><span style=3D"font-family:&#39;C=
ourier New&#39;">consumer.c:749: warning: implicit declaration of function =
&#39;htobe64&#39;<u></u><u></u></span></p>
<p class=3D"" style=3D"margin-left:0.5in"><span style=3D"font-family:&#39;C=
ourier New&#39;">consumer.c:750: warning: implicit declaration of function =
&#39;htobe32&#39;<u></u><u></u></span></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">Could you please let me know what could be wrong here. Your h=
elp is appreciated. Except of lttng-tools, all other components have be suc=
cessfully build and installed.<u></u><u></u></p>
<p class=3D""><u></u>=A0<u></u></p>
<p class=3D"">Regards,<u></u><u></u></p>
<p class=3D"">Hari<u></u><u></u></p>
</div></div>
</div>

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div></div>

--047d7b6d7a72032ba704dac0d190--


--===============1260743462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1260743462==--
