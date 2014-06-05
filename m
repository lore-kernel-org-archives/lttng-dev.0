From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng kretprobe issue
Date: Thu, 5 Jun 2014 17:08:31 +0000 (UTC)
Message-ID: <301896191.27236.1401988111285.JavaMail.zimbra__27973.26955847$1401988163$gmane$org@efficios.com>
References: <CAP7TvLcyae2tvJQCmE00=QfmteB4byyKRY+SDkeYaVjF3z5GeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0287504290=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <CAP7TvLcyae2tvJQCmE00=QfmteB4byyKRY+SDkeYaVjF3z5GeA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tarek slaymia <tarek.slaymia@gmail.com>
Cc: lttng-dev@lists.lttng.org, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0287504290==
Content-Type: multipart/alternative;
	boundary="----=_Part_27235_1652636127.1401988111283"

------=_Part_27235_1652636127.1401988111283
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "tarek slaymia" <tarek.slaymia@gmail.com>
> To: lttng-dev@lists.lttng.org, lttng-dev-request@lists.lttng.org
> Sent: Thursday, May 29, 2014 3:53:10 PM
> Subject: [lttng-dev] lttng kretprobe issue

> Hi all

> when i replace a syscall function address for example sys_write using this
> function in my LKM module :

> xchg(&sys_call_table[__NR_write],my_own_write);

> In the normal case the content of sys_call_table[__NR_write] address changes
> and it displays the address of my_own_write using debug technique .

> I have an issue when tracing this change using lttng kretprobe :

> lttng enable-event sys_write -k --function sys_write

> The ip value of sys_write ( the same address of sys_call_table[__NR_write] )
> remains the same even after changing it by the new function address (address
> of my_own_write)
> Why the ip value of sys_write syscall displayed in lttng traces remains the
> same even after changing it ?

sys_write is a symbol, and its address does not change. You place the 
kretprobe on the symbol. 

What you are overwriting is the content of the sys_call_table array, not 
the address of the sys_write symbol. 

So the resulting behavior is very much expected. 

Thanks, 

Mathieu 

> Best regards.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_27235_1652636127.1401988111283
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><br></div><hr id=3D"zwchr"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"tarek s=
laymia" &lt;tarek.slaymia@gmail.com&gt;<br><b>To: </b>lttng-dev@lists.lttng=
.org, lttng-dev-request@lists.lttng.org<br><b>Sent: </b>Thursday, May 29, 2=
014 3:53:10 PM<br><b>Subject: </b>[lttng-dev] lttng kretprobe issue<br><div=
><br></div><div dir=3D"ltr"><div><div><div><div><div>Hi all<br><div><br></d=
iv></div>when i replace a syscall function address for example sys_write us=
ing this function in my LKM module :<br><div><br></div>xchg(&amp;sys_call_t=
able[__NR_write],my_own_write);<br><br></div>In the normal case the content=
 of sys_call_table[__NR_write]=20
address changes and it displays the address of my_own_write using debug=20
technique .<br><div><br></div></div>I have an issue when tracing this chang=
e using lttng kretprobe :<br><br>
lttng enable-event sys_write -k --function sys_write<br><br>&nbsp;The ip va=
lue of sys_write ( the same address of=20
sys_call_table[__NR_write] ) remains the same even after changing it by=20
the new function address (address of my_own_write) <br></div>Why the ip val=
ue of sys_write syscall displayed in lttng traces remains the same even aft=
er changing it ? &nbsp; </div></div></blockquote><div><br></div><div>sys_wr=
ite is a symbol, and its address does not change. You place the<br></div><d=
iv>kretprobe on the symbol.<br></div><div><br></div><div>What you are overw=
riting is the content of the sys_call_table array, not<br></div><div>the ad=
dress of the sys_write symbol.<br></div><div><br></div><div>So the resultin=
g behavior is very much expected.<br></div><div><br></div><div>Thanks,<br><=
/div><div><br></div><div>Mathieu<br></div><div><br></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><br></div>B=
est regards.</div><br>_______________________________________________<br>lt=
tng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org=
/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><br></div><div=
><br></div><div>-- <br></div><div><span name=3D"x"></span>Mathieu Desnoyers=
<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"></span><br></d=
iv></div></body></html>
------=_Part_27235_1652636127.1401988111283--


--===============0287504290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0287504290==--
