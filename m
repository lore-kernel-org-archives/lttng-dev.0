From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Multiple log level for SAME tracepoints
Date: Thu, 7 May 2015 17:32:47 +0000 (UTC)
Message-ID: <298327583.45553.1431019967896.JavaMail.zimbra__40629.419408697$1431020069$gmane$org@efficios.com>
References: <CAL1ZhONcn462-oWPKBB529YtwOaDaQDz04ETBHuiJtdKV1F_Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1762690752=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YqPfF-0008M0-Eh
 for lttng-dev@lists.lttng.org; Thu, 07 May 2015 13:32:54 -0400
In-Reply-To: <CAL1ZhONcn462-oWPKBB529YtwOaDaQDz04ETBHuiJtdKV1F_Wg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chidhu R <chid1989@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1762690752==
Content-Type: multipart/alternative;
	boundary="----=_Part_45552_1683173702.1431019967895"

------=_Part_45552_1683173702.1431019967895
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> Hi,

> I am having a situation where the same tracepoint should be used with
> multiple loglevels.

> Say for example, I have a tracepoint called HERE which prints the string "I
> am here". Consider the following code.

> int *a = (int *)malloc(10);
> if(a) {
> tracepoint(HERE); // This can be INFO log level
> }
> else {
> // Malloc failed
> tracepoint(HERE); // This is critical and needs CRIT log level.
> }

> I am trying not to define multiple tracepoints just for this case. Can we do
> this with LTTng?

No, this is not supported. 

Thanks, 

Mathieu 

> -- Chid

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_45552_1683173702.1431019967895
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi,<=
div><br></div><div>I am having a situation where the same tracepoint should=
 be used with multiple loglevels.&nbsp;</div><div><br></div><div>Say for ex=
ample, I have a tracepoint called HERE which prints the string "I am here".=
 Consider the following code.</div><div><br></div><div>int *a =3D (int *)ma=
lloc(10);</div><div>if(a) {</div><div>&nbsp; &nbsp;tracepoint(HERE); // Thi=
s can be INFO log level</div><div>}</div><div>else {</div><div>&nbsp; &nbsp=
;// Malloc failed</div><div>&nbsp; &nbsp;tracepoint(HERE); // This is criti=
cal and needs CRIT log level.</div><div>}</div><div><br></div><div>I am try=
ing not to define multiple tracepoints just for this case. Can we do this w=
ith LTTng?</div></div></blockquote><div><br></div><div>No, this is not supp=
orted.<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Ma=
thieu<br></div><div><br></div><blockquote style=3D"border-left:2px solid #1=
010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt;"><div dir=3D"ltr"><div><br></div><div>-- Chid</div></div><br>_=
______________________________________________<br>lttng-dev mailing list<br=
>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>-- <br>=
</div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>ht=
tp://www.efficios.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_45552_1683173702.1431019967895--


--===============1762690752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1762690752==--
