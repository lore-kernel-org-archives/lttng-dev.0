From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Mem leak in lttng_ust lttng_probes_get_event_list()
Date: Tue, 29 Mar 2016 14:35:05 +0000 (UTC)
Message-ID: <1591088638.38466.1459262105320.JavaMail.zimbra__26344.5892408074$1459262130$gmane$org@efficios.com>
References: <CACd+_b7QyU_npdoa-NzffgA2cJpLGu0c0Yajk+bQ+hhOP=6dkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1856248639302996460=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B1828A2C2E
 for <lttng-dev@lists.lttng.org>; Tue, 29 Mar 2016 14:35:06 +0000 (UTC)
In-Reply-To: <CACd+_b7QyU_npdoa-NzffgA2cJpLGu0c0Yajk+bQ+hhOP=6dkQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1856248639302996460==
Content-Type: multipart/alternative;
	boundary="----=_Part_38465_797695708.1459262105319"

------=_Part_38465_797695708.1459262105319
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

Please open an issue on the bug tracker with all the information requested 
in the bug reporting guidelines. See https://bugs.lttng.org/ 

Thanks, 

Mathieu 

----- On Mar 28, 2016, at 2:09 AM, Aravind HT <aravind.ht@gmail.com> wrote: 

> Hi,
> I have seen that the RES mem from TOP increases over time for an application
> that
> is being traced. When analyzed with valgrind, I see the following

> ==12429== 175,824 bytes in 594 blocks are possibly lost in loss record 30 of 30
> ==12429== at 0x4C29810: calloc (in
> /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==12429== by 0x54AF21E: calloc (in
> /usr/lib64/liblttng-ust-libc-wrapper.so.0.0.0)
> ==12429== by 0x526C27B: lttng_probes_get_event_list (in
> /usr/lib64/liblttng-ust.so.0.0.0)
> ==12429== by 0x526AD9E: ??? (in /usr/lib64/liblttng-ust.so.0.0.0)
> ==12429== by 0x5267FAF: ??? (in /usr/lib64/liblttng-ust.so.0.0.0)
> ==12429== by 0x503CFE2: start_thread (pthread_create.c:312)
> ==12429== by 0x579BAFC: clone (clone.S:111)

> There is a memleak seen when lttng_probes_get_event_list() gets called during
> listing of
> trace points, example "lttng list -u". Each time lttng_probes_get_event_list()
> gets called,
> objd_alloc() is called and a new list of trace points generated in
> lttng_probes_get_event_list()
> and stored.
> This entry in the objd_table is not reused when "lttng list -u" gets called
> again in the future
> and is also not removed until the application exits resulting in memory
> consumption.

> I can see that the objd_table is meant to be used as a cache but somehow the
> full implementation is not present..is this a work still in progress ? If not,
> to solve this, whenever lttng_probes_get_event_list() is called, we could check
> if we have results available in the objd_table from an earlier call for a
> particular owner and name and re-use it.

> Regards,
> Aravind.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_38465_797695708.1459262105319
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>Please open an issue on the bug tracker with all the information=
 requested</div><div>in the bug reporting guidelines. See https://bugs.lttn=
g.org/<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br></div><span id=3D"zwc=
hr" data-marker=3D"__DIVIDER__">----- On Mar 28, 2016, at 2:09 AM, Aravind =
HT &lt;aravind.ht@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOT=
ED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div =
dir=3D"ltr">Hi,<br><div><div>I have seen that the RES mem from TOP increase=
s over time for an application that</div><div>is being traced. When analyze=
d with valgrind, I see the following</div><br><div>=3D=3D12429=3D=3D 175,82=
4 bytes in 594 blocks are possibly lost in loss record 30 of 30</div><div>=
=3D=3D12429=3D=3D &nbsp; &nbsp;at 0x4C29810: calloc (in /usr/lib64/valgrind=
/vgpreload_memcheck-amd64-linux.so)</div><div>=3D=3D12429=3D=3D &nbsp; &nbs=
p;by 0x54AF21E: calloc (in /usr/lib64/liblttng-ust-libc-wrapper.so.0.0.0)</=
div><div>=3D=3D12429=3D=3D &nbsp; &nbsp;by 0x526C27B: lttng_probes_get_even=
t_list (in /usr/lib64/liblttng-ust.so.0.0.0)</div><div>=3D=3D12429=3D=3D &n=
bsp; &nbsp;by 0x526AD9E: ??? (in /usr/lib64/liblttng-ust.so.0.0.0)</div><di=
v>=3D=3D12429=3D=3D &nbsp; &nbsp;by 0x5267FAF: ??? (in /usr/lib64/liblttng-=
ust.so.0.0.0)</div><div>=3D=3D12429=3D=3D &nbsp; &nbsp;by 0x503CFE2: start_=
thread (pthread_create.c:312)</div><div>=3D=3D12429=3D=3D &nbsp; &nbsp;by 0=
x579BAFC: clone (clone.S:111)</div><br><br><div>There is a memleak seen whe=
n lttng_probes_get_event_list() gets called during listing of &nbsp;</div><=
div>trace points, example "lttng list -u". Each time lttng_probes_get_event=
_list() gets called,</div><div>objd_alloc() is called and a new list of tra=
ce points generated in lttng_probes_get_event_list()</div><div>and stored.<=
/div><div>This entry in the objd_table is not reused when "lttng list -u" g=
ets called again in the future&nbsp;</div><div>and is also not removed unti=
l the application exits resulting in memory consumption.&nbsp;</div><br><di=
v>I can see that the objd_table is meant to be used as a cache but somehow =
the full implementation is not present..is this a work still in progress ? =
If not, to solve this, whenever lttng_probes_get_event_list() is called, we=
 could check if we have results available in the objd_table from an earlier=
 call for a particular owner and name and re-use it.&nbsp;</div></div><br><=
div>Regards,</div><div>Aravind.</div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST=
__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effi=
cios.com</div></div></body></html>
------=_Part_38465_797695708.1459262105319--

--===============1856248639302996460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1856248639302996460==--
