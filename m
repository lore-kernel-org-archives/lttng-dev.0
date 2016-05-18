From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: question about  rcu_bp_exit()
Date: Wed, 18 May 2016 18:40:03 +0000 (UTC)
Message-ID: <971830834.12745.1463596803434.JavaMail.zimbra__41415.1166486137$1463596833$gmane$org@efficios.com>
References: <6db07fb4.c6e5.154c340296f.Coremail.songxin_1980@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6622506624460113517=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C2E36A3596
 for <lttng-dev@lists.lttng.org>; Wed, 18 May 2016 18:40:08 +0000 (UTC)
In-Reply-To: <6db07fb4.c6e5.154c340296f.Coremail.songxin_1980@126.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: songxin <songxin_1980@126.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============6622506624460113517==
Content-Type: multipart/alternative;
	boundary="----=_Part_12744_252826321.1463596803422"

------=_Part_12744_252826321.1463596803422
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On May 18, 2016, at 5:44 AM, songxin <songxin_1980@126.com> wrote: 

> Hi,
> Now I get a crash because receiving signal SIGSEGV as below.

> #0 arena_alloc (arena=<optimized out>) at
> /usr/src/debug/liburcu/0.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0/git/urcu-bp.c:432
> #1 add_thread () at
> /usr/src/debug/liburcu/0.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0/git/urcu-bp.c:462
> #2 rcu_bp_register () at
> /usr/src/debug/liburcu/0.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0/git/urcu-bp.c:541

> I read the code of urcu-bp.c and found that "if (chunk->data_len - chunk->used <
> len)" is in 432 line. So I guess that the chunk is a illegal pointer.
> Below is the function rcu_bp_exit().

> static
> void rcu_bp_exit(void)
> {
> mutex_lock(&init_lock);
> if (!--rcu_bp_refcount) {
> struct registry_chunk *chunk, *tmp;
> int ret;

> cds_list_for_each_entry_safe(chunk, tmp,
> &registry_arena.chunk_list, node) {
> munmap(chunk, chunk->data_len
> + sizeof(struct registry_chunk));
> }
> ret = pthread_key_delete(urcu_bp_key);
> if (ret)
> abort();
> }
> mutex_unlock(&init_lock);
> }

> My question is below.
> Why did not delete the chunk from registry_arena.chunk_list before munmap a
> chunk?

It is not expected that any thread would be created after the execution of 
rcu_bp_exit() as a library destructor. Does re-initializing the chunk_list after 
iterating on it within rcu_bp_exit() fix your issue ? 

I'm curious about your use-case for creating threads after the library destructor 
has run. 

Thanks, 

Mathieu 

> Thanks,
> xin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_12744_252826321.1463596803422
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On May 18, 2016, at 5:44 AM, songxin &lt;songxin_1980@126.com&gt;=
 wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote st=
yle=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color=
:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family=
:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"line-height:1.7;=
color:#000000;font-size:14px;font-family:Arial"><div>Hi,</div><div>Now I ge=
t a crash because receiving signal SIGSEGV as below.</div><br><div><span st=
yle=3D"font-family: sans-serif; font-size: small;" data-mce-style=3D"font-f=
amily: sans-serif; font-size: small;" size=3D"2" face=3D"sans-serif">#0 &nb=
sp;arena_alloc (arena=3D&lt;optimized=20
out&gt;) at=20
/usr/src/debug/liburcu/0.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0=
/git/urcu-bp.c:432</span></div><span style=3D"font-family: sans-serif; font=
-size: small;" data-mce-style=3D"font-family: sans-serif; font-size: small;=
" size=3D"2" face=3D"sans-serif">#1 &nbsp;add_thread () at /usr/src/debug/l=
iburcu/0.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0/git/urcu-bp.c:4=
62</span><br><div><span style=3D"font-family: sans-serif; font-size: small;=
" data-mce-style=3D"font-family: sans-serif; font-size: small;" size=3D"2" =
face=3D"sans-serif">#2 &nbsp;rcu_bp_register () at /usr/src/debug/liburcu/0=
.9.1+git5fd33b1e5003ca316bd314ec3fd1447f6199a282-r0/git/urcu-bp.c:541</span=
></div><div><span style=3D"font-family: sans-serif; font-size: small;" data=
-mce-style=3D"font-family: sans-serif; font-size: small;" size=3D"2" face=
=3D"sans-serif"><br></span></div><div>I read the code of&nbsp;urcu-bp.c and=
 found &nbsp;that &nbsp;"if (chunk-&gt;data_len - chunk-&gt;used &lt; len)"=
 is in 432 line. So I guess that the chunk is a illegal pointer.</div><div>=
Below is the function rcu_bp_exit().</div><br><div><div>static</div><div>vo=
id rcu_bp_exit(void)</div><div>{</div><div>&nbsp; &nbsp; &nbsp; &nbsp; mute=
x_lock(&amp;init_lock);</div><div>&nbsp; &nbsp; &nbsp; &nbsp; if (!--rcu_bp=
_refcount) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; struct registry_chunk *chunk, *tmp;</div><div>&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; int ret;</div><br><div>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cds_list_for_each_entry_safe(chunk, tmp,=
</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &amp;registry_arena.chunk_l=
ist, node) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; munmap(chunk, chunk-&gt;data_len</div><div>=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; + sizeof(s=
truct registry_chunk));</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; }</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; ret =3D pthread_key_delete(urcu_bp_key);</div><div>&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (ret)</div><div>&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; abort()=
;</div><div>&nbsp; &nbsp; &nbsp; &nbsp; }</div><div>&nbsp; &nbsp; &nbsp; &n=
bsp; mutex_unlock(&amp;init_lock);</div><div>}</div></div><br><br><div>My q=
uestion is below.</div><div>Why did not delete the chunk from&nbsp;<span st=
yle=3D"line-height: 23.8px;">registry_arena.chunk_list before munmap a chun=
k?</span></div></div></blockquote><div><br></div><div>It is not expected th=
at any thread would be created after the execution of<br data-mce-bogus=3D"=
1"></div><div>rcu_bp_exit() as a library destructor. Does re-initializing t=
he chunk_list after</div><div>iterating on it within rcu_bp_exit() fix your=
 issue ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div>=
<div>I'm curious about your use-case for creating threads after the library=
 destructor</div><div>has run.<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br d=
ata-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1=
010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt;"><div style=3D"line-height:1.7;color:#000000;font-size:14px;fo=
nt-family:Arial"><div><span style=3D"line-height: 23.8px;"><br></span></div=
><div><span style=3D"line-height: 23.8px;">Thanks,</span></div><div><span s=
tyle=3D"line-height: 23.8px;">xin</span></div><br></div><br><br><br>_______=
________________________________________<br>lttng-dev mailing list<br>lttng=
-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST=
__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effi=
cios.com</div></div></body></html>
------=_Part_12744_252826321.1463596803422--

--===============6622506624460113517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6622506624460113517==--
