From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deadlock in call_rcu_thread when destroy rculfhash
 node with nested rculfhash
Date: Wed, 19 Oct 2016 15:03:32 +0000 (UTC)
Message-ID: <85898265.59079.1476889412542.JavaMail.zimbra__46126.3548852459$1476889352$gmane$org@efficios.com>
References: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
 <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4316990406096547460=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 89FE0A43BC
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 15:04:06 +0000 (UTC)
In-Reply-To: <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeniy Ivanov <i@eivanov.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4316990406096547460==
Content-Type: multipart/alternative;
	boundary="=_c46e4ab0-f605-409d-ac4b-9b28d2b1bcec"

--=_c46e4ab0-f605-409d-ac4b-9b28d2b1bcec
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is because we use call_rcu internally to trigger the hash table 
resize. 

In cds_lfht_destroy, we start by waiting for "in-flight" resize to complete. 
Unfortunately, this requires that call_rcu worker thread progresses. If 
cds_lfht_destroy is called from the call_rcu worker thread, it will wait 
forever. 

One alternative would be to implement our own worker thread scheme 
for the rcu HT resize rather than use the call_rcu worker thread. This 
would simplify cds_lfht_destroy requirements a lot. 

Ideally I'd like to re-use all the call_rcu work dispatch/worker handling 
scheme, just as a separate work queue. 

Thoughts ? 

Thanks, 

Mathieu 

----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov <i@eivanov.com> wrote: 

> Sorry, found partial answer in docs which state that cds_lfht_destroy should not
> be called from a call_rcu thread context. Why does this limitation exists?

> On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov < [ mailto:i@eivanov.com |
> i@eivanov.com ] > wrote:

>> Hi,

>> Each node of top level rculfhash has nested rculfhash. Some thread clears the
>> top level map and then uses rcu_barrier() to wait until everything is destroyed
>> (it is done to check leaks). Recently it started to dead lock sometimes with
>> following stacks:

>> Thread1:

>> __poll
>> cds_lfht_destroy <---- nested map
>> ...
>> free_Node(rcu_head*) <----- node of top level map
>> call_rcu_thread

>> Thread2:

>> syscall
>> rcu_barrier_qsbr
>> destroy_all
>> main

>> Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
>> internal deadlock because of nested maps?

>> --
>> Cheers,
>> Evgeniy

> --
> Cheers,
> Evgeniy

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_c46e4ab0-f605-409d-ac4b-9b28d2b1bcec
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>This is because we use call_rcu internally =
to trigger the hash table<br></div><div>resize.<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>In cds_lfht_destroy, we start b=
y waiting for "in-flight" resize to complete.<br data-mce-bogus=3D"1"></div=
><div>Unfortunately, this requires that call_rcu worker thread progresses. =
If<br></div><div>cds_lfht_destroy is called from the call_rcu worker thread=
, it will wait<br data-mce-bogus=3D"1"></div><div>forever.<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>One alternative woul=
d be to implement our own worker thread scheme<br data-mce-bogus=3D"1"></di=
v><div>for the rcu HT resize rather than use the call_rcu worker thread. Th=
is</div><div>would simplify cds_lfht_destroy requirements a lot.<br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Ideally I'd li=
ke to re-use all the call_rcu work dispatch/worker handling<br data-mce-bog=
us=3D"1"></div><div>scheme, just as a separate work queue.<br data-mce-bogu=
s=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thoughts ?<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br da=
ta-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<b=
r data-mce-bogus=3D"1"></div><div><br></div><span id=3D"zwchr" data-marker=
=3D"__DIVIDER__">----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov &lt;i@ei=
vanov.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Sorry,=
 found partial answer in docs which state that&nbsp;cds_lfht_destroy should=
 not be called&nbsp;from a call_rcu thread context. Why does this limitatio=
n exists?</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:i@eivanov.com" target=3D"_blank">i@eivanov.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<br><br>Each no=
de of top level rculfhash has nested rculfhash. Some thread clears the top =
level map and then uses rcu_barrier() to wait until everything is destroyed=
 (it is done to check leaks). Recently it started to dead lock sometimes wi=
th following stacks:<br><br>Thread1:<br><span style=3D"font-family: monospa=
ce,monospace;" data-mce-style=3D"font-family: monospace,monospace;" face=3D=
"monospace, monospace"><br></span><div><span style=3D"font-family: monospac=
e,monospace;" data-mce-style=3D"font-family: monospace,monospace;" face=3D"=
monospace, monospace">__poll<br>cds_lfht_destroy &nbsp; &nbsp;&lt;---- nest=
ed map<br>...<br>free_Node(rcu_head*) &nbsp;&lt;----- node of top level map=
<br>call_rcu_thread<br></span><br>Thread2:<div><br><span style=3D"font-fami=
ly: monospace,monospace;" data-mce-style=3D"font-family: monospace,monospac=
e;" face=3D"monospace, monospace">syscall <br>rcu_barrier_qsbr <br>destroy_=
all<br>main<br></span><br><br>Did&nbsp;call_rcu_thread dead lock with barri=
er thread? Or is it some kind of internal deadlock because of nested maps?<=
span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"col=
or: #888888;" color=3D"#888888"><br><br><br>-- <br>Cheers,<br>Evgeniy</span=
></span></div></div></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature">Cheers,<br>Evgeniy</div>
</div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST=
__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effi=
cios.com</div></div></body></html>
--=_c46e4ab0-f605-409d-ac4b-9b28d2b1bcec--

--===============4316990406096547460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4316990406096547460==--
