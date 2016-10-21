From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Deadlock in call_rcu_thread when destroy rculfhash
 node with nested rculfhash
Date: Fri, 21 Oct 2016 11:19:50 +0300
Message-ID: <CAO6Ho0d+LkJi_2ebomx13D42CApEG-bakyTbtzvz+Jvxc4wy9A__21294.4167702974$1477038030$gmane$org@mail.gmail.com>
References: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
 <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g@mail.gmail.com>
 <85898265.59079.1476889412542.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5436035697027620663=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
 [209.85.214.48])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 389F4A45F0
 for <lttng-dev@lists.lttng.org>; Fri, 21 Oct 2016 08:21:59 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id 139so212154349itm.1
 for <lttng-dev@lists.lttng.org>; Fri, 21 Oct 2016 01:19:53 -0700 (PDT)
In-Reply-To: <85898265.59079.1476889412542.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5436035697027620663==
Content-Type: multipart/alternative; boundary=94eb2c05a1b4cb54b8053f5bb4c0

--94eb2c05a1b4cb54b8053f5bb4c0
Content-Type: text/plain; charset=UTF-8

On Wed, Oct 19, 2016 at 6:03 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> This is because we use call_rcu internally to trigger the hash table
> resize.
>
> In cds_lfht_destroy, we start by waiting for "in-flight" resize to
> complete.
> Unfortunately, this requires that call_rcu worker thread progresses. If
> cds_lfht_destroy is called from the call_rcu worker thread, it will wait
> forever.
>
> One alternative would be to implement our own worker thread scheme
> for the rcu HT resize rather than use the call_rcu worker thread. This
> would simplify cds_lfht_destroy requirements a lot.
>
> Ideally I'd like to re-use all the call_rcu work dispatch/worker handling
> scheme, just as a separate work queue.
>
> Thoughts ?
>

Thank you for explaining. Sounds like a plan: in our prod there is no issue
with having extra thread for table resizes. And nested tables is important
feature.



>
Thanks,
>
> Mathieu
>
> ----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov <i@eivanov.com> wrote:
>
> Sorry, found partial answer in docs which state that cds_lfht_destroy
> should not be called from a call_rcu thread context. Why does this
> limitation exists?
>
> On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov <i@eivanov.com> wrote:
>
>> Hi,
>>
>> Each node of top level rculfhash has nested rculfhash. Some thread clears
>> the top level map and then uses rcu_barrier() to wait until everything is
>> destroyed (it is done to check leaks). Recently it started to dead lock
>> sometimes with following stacks:
>>
>> Thread1:
>>
>> __poll
>> cds_lfht_destroy    <---- nested map
>> ...
>> free_Node(rcu_head*)  <----- node of top level map
>> call_rcu_thread
>>
>> Thread2:
>>
>> syscall
>> rcu_barrier_qsbr
>> destroy_all
>> main
>>
>>
>> Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
>> internal deadlock because of nested maps?
>>
>>
>> --
>> Cheers,
>> Evgeniy
>>
>
>
>
> --
> Cheers,
> Evgeniy
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


-- 
Cheers,
Evgeniy

--94eb2c05a1b4cb54b8053f5bb4c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Oct 19, 2016 at 6:03 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desno=
yers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif=
;font-size:12pt;color:rgb(0,0,0)"><div>This is because we use call_rcu inte=
rnally to trigger the hash table<br></div><div>resize.<br></div><div><br></=
div><div>In cds_lfht_destroy, we start by waiting for &quot;in-flight&quot;=
 resize to complete.<br></div><div>Unfortunately, this requires that call_r=
cu worker thread progresses. If<br></div><div>cds_lfht_destroy is called fr=
om the call_rcu worker thread, it will wait<br></div><div>forever.<br></div=
><div><br></div><div>One alternative would be to implement our own worker t=
hread scheme<br></div><div>for the rcu HT resize rather than use the call_r=
cu worker thread. This</div><div>would simplify cds_lfht_destroy requiremen=
ts a lot.<br></div><div><br></div><div>Ideally I&#39;d like to re-use all t=
he call_rcu work dispatch/worker handling<br></div><div>scheme, just as a s=
eparate work queue.<br></div><div><br></div><div>Thoughts ?<br></div><div><=
span style=3D"font-family:arial,sans-serif;font-size:small;color:rgb(34,34,=
34)"></span></div></div></div></blockquote><div><br></div><div>Thank you fo=
r explaining. Sounds like a plan: in our prod there is no issue with having=
 extra thread for table resizes. And nested tables is important feature.<br=
></div><div><br></div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-=
size:12pt;color:rgb(0,0,0)"><div><span style=3D"font-family:arial,sans-seri=
f;font-size:small;color:rgb(34,34,34)">=C2=A0</span><br></div></div></div><=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div sty=
le=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0=
)"><div></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><d=
iv><div class=3D"gmail-h5"><div><br></div><span id=3D"gmail-m_1548600653268=
589583zwchr">----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov &lt;<a href=
=3D"mailto:i@eivanov.com" target=3D"_blank">i@eivanov.com</a>&gt; wrote:<br=
></span></div></div><div><blockquote style=3D"border-left:2px solid rgb(16,=
16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:helvetica,arial,sans-s=
erif;font-size:12pt"><div><div class=3D"gmail-h5"><div dir=3D"ltr">Sorry, f=
ound partial answer in docs which state that=C2=A0cds_lfht_destroy should n=
ot be called=C2=A0from a call_rcu thread context. Why does this limitation =
exists?</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On W=
ed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov <span dir=3D"ltr">&lt;<a href=
=3D"mailto:i@eivanov.com" target=3D"_blank">i@eivanov.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
Hi,<br><br>Each node of top level rculfhash has nested rculfhash. Some thre=
ad clears the top level map and then uses rcu_barrier() to wait until every=
thing is destroyed (it is done to check leaks). Recently it started to dead=
 lock sometimes with following stacks:<br><br>Thread1:<br><span style=3D"fo=
nt-family:monospace,monospace" face=3D"monospace, monospace"><br></span><di=
v><span style=3D"font-family:monospace,monospace" face=3D"monospace, monosp=
ace">__poll<br>cds_lfht_destroy =C2=A0 =C2=A0&lt;---- nested map<br>...<br>=
free_Node(rcu_head*) =C2=A0&lt;----- node of top level map<br>call_rcu_thre=
ad<br></span><br>Thread2:<div><br><span style=3D"font-family:monospace,mono=
space" face=3D"monospace, monospace">syscall <br>rcu_barrier_qsbr <br>destr=
oy_all<br>main<br></span><br><br>Did=C2=A0call_rcu_thread dead lock with ba=
rrier thread? Or is it some kind of internal deadlock because of nested map=
s?<span class=3D"gmail-m_1548600653268589583HOEnZb"><span style=3D"color:rg=
b(136,136,136)" color=3D"#888888"><br><br><br>-- <br>Cheers,<br>Evgeniy</sp=
an></span></div></div></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail-m_1=
548600653268589583gmail_signature">Cheers,<br>Evgeniy</div>
</div>
<br></div></div>______________________________<wbr>_________________<br>ltt=
ng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=
=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng=
.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lt=
tng.org/cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><span class=3D"gmail-HOE=
nZb"><font color=3D"#888888"><br></font></span></blockquote></div><span cla=
ss=3D"gmail-HOEnZb"><font color=3D"#888888"><br><div>-- <br></div><div>Math=
ieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" targe=
t=3D"_blank">http://www.efficios.com</a></div></font></span></div></div><br=
>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">Cheers,<br>Evgeniy</div>
</div></div>

--94eb2c05a1b4cb54b8053f5bb4c0--

--===============5436035697027620663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5436035697027620663==--
