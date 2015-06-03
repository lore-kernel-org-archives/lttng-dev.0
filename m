From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng kernel events
Date: Wed, 3 Jun 2015 07:24:37 +0000 (UTC)
Message-ID: <1913613869.2576.1433316277001.JavaMail.zimbra__47244.0912425101$1433316378$gmane$org@efficios.com>
References: <CAPxN80CcSme-h=OJ3L33+1FAW-X8qCYFF7Trpy=LSX2D6QouOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0746789529=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <CAPxN80CcSme-h=OJ3L33+1FAW-X8qCYFF7Trpy=LSX2D6QouOA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0746789529==
Content-Type: multipart/alternative;
	boundary="----=_Part_2575_1689409624.1433316277000"

------=_Part_2575_1689409624.1433316277000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 1, 2015, at 5:15 PM, Jessica Foest <jessica.foest@gmail.com> wrote: 

> Hi all,
> Normally the following perf software event means the same thing :

> page-faults OR faults
> context-switches OR cs
> cpu-migrations OR migrations

> The questions is why both of them (the two representation of the event) are
> presented in the context options of LTTng?

> When i try to activate them when tracing the kernel activities no error
> displayed, it means that both of them works fine.

> is that normal ?

Yes, we support both the long forms and the shortcuts. Those may have the 
same meaning indeed. 

Thanks, 

Mathieu 

> Regards

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_2575_1689409624.1433316277000
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Jun 1, 2015, at 5:15 PM, Jessica Foes=
t &lt;jessica.foest@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QU=
OTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><di=
v dir=3D"ltr">Hi all,<br><div>Normally the following perf software event me=
ans the same thing :<br></div><div><br><div>page-faults OR faults</div><div=
>context-switches OR cs&nbsp;</div><div>cpu-migrations OR migrations&nbsp;<=
/div></div><br><div>The questions is why both of them (the two representati=
on of the event) are presented in the context options of LTTng?</div><br><d=
iv>When i try to activate them when tracing the kernel activities no error =
displayed, it means that both of them works fine.</div><br><div>is that nor=
mal ?</div></div></blockquote><div>Yes, we support both the long forms and =
the shortcuts. Those may have the<br></div><div>same meaning indeed.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathie=
u<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><div dir=3D"ltr"><br><div>Regards<br></div><div><br></div></di=
v><br>_______________________________________________<br>lttng-dev mailing =
list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POS=
T__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.eff=
icios.com</div></div></body></html>
------=_Part_2575_1689409624.1433316277000--


--===============0746789529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0746789529==--
