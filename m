From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Tue, 14 Jul 2015 00:17:39 +0530
Message-ID: <CACd+_b5dwMRdR8wjzG0S5wpwtuB+qx_Q4Y0RHA2GDw7ZZgny+A__32914.3070885495$1436813315$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
 <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
 <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA@mail.gmail.com>
 <CA+jJMxtyOqTDSh3iphDAE4qPx0+C8jJ3Txi1j+ouxHx0guuXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1425057862=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZEilV-0001Mf-IN
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 14:47:47 -0400
Received: by lbbpo10 with SMTP id po10so130265075lbb.3
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2015 11:47:39 -0700 (PDT)
In-Reply-To: <CA+jJMxtyOqTDSh3iphDAE4qPx0+C8jJ3Txi1j+ouxHx0guuXng@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1425057862==
Content-Type: multipart/alternative; boundary=047d7b3a81feeedad3051ac62747

--047d7b3a81feeedad3051ac62747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The specific change in
http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80
that I need is for cds_list_del(&stream->recv_list); to be called.
Below is the patch extract.

diff --git a/src/bin/lttng-relayd/main.c
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
b/src/bin/lttng-relayd/main.c
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9=
e4d0d03b865bb7fc6a905f80>

index a93151a
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
..d82a341
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9=
e4d0d03b865bb7fc6a905f80>
100644 (file)
--- a/src/bin/lttng-relayd/main.c
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
+++ b/src/bin/lttng-relayd/main.c
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9=
e4d0d03b865bb7fc6a905f80>
@@ -1340,6
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc#l1340>
+1340,18
<http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9=
e4d0d03b865bb7fc6a905f80#l1340>
@@ int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
        session->stream_count--;
        assert(session->stream_count >=3D 0);

+       /*
+        * Remove the stream from the connection recv list since we are abo=
ut to
+        * flag it invalid and thus might be freed. This has to be
done here since
+        * only the control thread can do actions on that list.
+        *
+        * Note that this stream might NOT be in the list but we have to tr=
y to
+        * remove it here else this can race with the stream destruction fr=
eeing
+        * the object and the connection destroy doing a use after free whe=
n
+        * deleting the remaining nodes in this list.
+        */
+       cds_list_del(&stream->recv_list);
+
        /* Check if we can close it or else the data will do it. */
        try_close_stream(session, stream);






On Mon, Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Do you have a specific changeset in mind when you say you applied the
> changes mentioned in that thread?
>
> Do you simply revert the following commit?
>
> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c033=
1445346b15f
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
>
> On Sat, Jul 11, 2015 at 3:26 AM, Aravind HT <aravind.ht@gmail.com> wrote:
>
>> To try this fix, I also needed the changes talked about in
>> http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html ,
>> otherwise, I would see relayd coring.
>> Once I took them I could see that the soft hang issue was no longer
>> reproducible.
>>
>> Thanks for helping.
>>
>> On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <aravind.ht@gmail.com> wrote:
>>
>>> Sure, I will try the fix and update.
>>>
>>> On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
>>> jeremie.galarneau@efficios.com> wrote:
>>>
>>>> Would you mind testing Mathieu's patch?
>>>>
>>>> I have rebased it on stable-2.6:
>>>> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>>>>
>>>> Thanks,
>>>> J=C3=A9r=C3=A9mie=EF=BF=BC
>>>>
>>>>
>>>> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
>>>> jeremie.galarneau@efficios.com> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> What do you observe when this happens? Does the session daemon become
>>>>> unresponsive?
>>>>>
>>>>> J=C3=A9r=C3=A9mie
>>>>>
>>>>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> Request someone to kindly help with this. Blocked at this point,
>>>>>> unable to continue as any application crash leads to lttng not worki=
ng.
>>>>>>
>>>>>> Thanks,
>>>>>> Aravind.
>>>>>>
>>>>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>>>>>> wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I have recently started trying lttng 2.6 for a few applications on
>>>>>>> my Ubuntu 12.04 and I noticed that the health check on sessiond and
>>>>>>> consumerd failed soon after starting the session.
>>>>>>>
>>>>>>>
>>>>>>> On investigating, I found that thread_manage_consumer() had exited
>>>>>>> causing an overall health check failure.
>>>>>>>
>>>>>>>
>>>>>>> Here are the sequence of steps that I found contributed to
>>>>>>> *thread_manage_consumer()* exiting.
>>>>>>>
>>>>>>>
>>>>>>> 1.       In *thread_manage_apps() : 1558 ,
>>>>>>> ust_app_unregister(pollfd)* is being called. This happens when
>>>>>>> there is an error detected by *revents =3D LTTNG_POLL_GETEV(&events=
,
>>>>>>> i)*
>>>>>>>
>>>>>>> My initial guess here is that as one of my apps has crashed,
>>>>>>> producing a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated for
>>>>>>> *epoll()* causing *ust_app_unregister()* to be called for that app.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is =
set
>>>>>>> *.*
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> (2.a) Note:* close_metadata() *also calls
>>>>>>> * consumer_close_metadata() *which sends
>>>>>>> * LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>>>>>> consumerd to stop it from further dealing with the concerned app. S=
omehow
>>>>>>> this doesn=E2=80=99t seem to help*.*
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for
>>>>>>> some reason has ignored the above 2.a and gets to do request/reply =
for that
>>>>>>> app by calling*ust_consumer_metadata_request():491 ->
>>>>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks
>>>>>>> for *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up t=
o
>>>>>>> *thread_manage_consumer():1353* at which point
>>>>>>> *thread_manage_consumer()* decides to exit causing health_check()
>>>>>>> to fail.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> So it looks like under some scenario, an application crash could
>>>>>>> cause the lttng some problems.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> I think a possible fix for this scenario, is to instead of 4, send
>>>>>>> an *ERROR* message back to *consumerd()* . This could be done from
>>>>>>> *ust_consumer_metadata_request()* call. Can someone please let me
>>>>>>> know if this is correct and shed more light on the issue ?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Please forgive if there are any guideline omissions for posting her=
e
>>>>>>> from my part. This is my first post.
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Aravind.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> _______________________________________________
>>>>>> lttng-dev mailing list
>>>>>> lttng-dev@lists.lttng.org
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
>>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b3a81feeedad3051ac62747
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The specific change in=C2=A0<a href=3D"http://git.lttng.or=
g/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6=
a905f80">http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef=
1ef1d54ced9e4d0d03b865bb7fc6a905f80</a><div>that I need is for=C2=A0<span s=
tyle=3D"color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Vera Sans Mono=
&#39;,monospace;font-size:13px;line-height:18.2000007629395px;white-space:p=
re-wrap;background-color:rgb(221,255,221)">cds_list_del(&amp;stream-&gt;rec=
v_list); to be called.=C2=A0</span></div><div><span style=3D"color:rgb(0,0,=
0);font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;font-s=
ize:13px;line-height:18.2000007629395px;white-space:pre-wrap;background-col=
or:rgb(221,255,221)">Below is the patch extract.</span></div><div><span sty=
le=3D"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream V=
era Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-space:pre=
-wrap;background-color:rgb(234,242,245)"><br></span></div><div><span style=
=3D"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Ver=
a Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-space:pre-w=
rap;background-color:rgb(234,242,245)">diff --git </span><a href=3D"http://=
git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c=
;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc" class=3D"" style=3D"font-siz=
e:13px;margin:0px;padding:0px;border:0px;outline:none;vertical-align:baseli=
ne;color:rgb(65,131,196);text-decoration:none;font-family:Consolas,&#39;Bit=
stream Vera Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-s=
pace:pre-wrap;background:transparent">a/src/bin/lttng-relayd/main.c</a><spa=
n style=3D"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;Bitstr=
eam Vera Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-spac=
e:pre-wrap;background-color:rgb(234,242,245)"> </span><a class=3D"" href=3D=
"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relay=
d/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9=
e4d0d03b865bb7fc6a905f80" style=3D"font-size:13px;margin:0px;padding:0px;bo=
rder:0px;outline:none;vertical-align:baseline;color:rgb(65,131,196);text-de=
coration:none;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monos=
pace;line-height:18.2000007629395px;white-space:pre-wrap;background:transpa=
rent">b/src/bin/lttng-relayd/main.c</a></div><div><br></div><div><div class=
=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px=
;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono=
&#39;,monospace;width:1480.5625px;white-space:pre-wrap;color:rgb(0,0,0);lin=
e-height:18.2000007629395px;background:rgb(248,248,248)">index <a class=3D"=
" href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lt=
tng-relayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc" style=3D"ma=
rgin:0px;padding:0px;border:0px;outline:none;vertical-align:baseline;color:=
rgb(65,131,196);text-decoration:none;background:transparent">a93151a</a>..<=
a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lt=
tng-relayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1e=
f1d54ced9e4d0d03b865bb7fc6a905f80" class=3D"" style=3D"margin:0px;padding:0=
px;border:0px;outline:none;vertical-align:baseline;color:rgb(65,131,196);te=
xt-decoration:none;background:transparent">d82a341</a> 100644<span class=3D=
"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;vertical-align:ba=
seline;background:transparent"> (file)</span><br>
</div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0p=
x;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstrea=
m Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(170,0,0);lin=
e-height:18.2000007629395px;background:rgb(248,248,248)">--- a/<a href=3D"h=
ttp://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/=
main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc" class=3D"" style=3D"ma=
rgin:0px;padding:0px;border:0px;outline:none;vertical-align:baseline;color:=
rgb(170,0,0);text-decoration:none;background:transparent">src/bin/lttng-rel=
ayd/main.c</a></div><div class=3D"" style=3D"margin:0px;padding:0px;border:=
0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas=
,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rg=
b(0,112,0);line-height:18.2000007629395px;background:rgb(248,248,248)">+++ =
b/<a class=3D"" href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;=
f=3Dsrc/bin/lttng-relayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07b=
c;hb=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" style=3D"margin:0px;paddin=
g:0px;border:0px;outline:none;vertical-align:baseline;color:rgb(0,112,0);te=
xt-decoration:none;background:transparent">src/bin/lttng-relayd/main.c</a><=
/div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px=
;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream=
 Vera Sans Mono&#39;,monospace;color:rgb(153,153,153);white-space:pre-wrap;=
line-height:18.2000007629395px;background:rgb(234,242,245)"><span class=3D"=
" style=3D"margin:0px;padding:0px;border:0px;outline:0px;vertical-align:bas=
eline;background:transparent">@@ <a href=3D"http://git.lttng.org/?p=3Dlttng=
-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Da93151ac47f560875f0=
7c9cbf113225f9dd892cc#l1340" class=3D"" style=3D"margin:0px;padding:0px;bor=
der:0px;outline:none;vertical-align:baseline;color:rgb(65,131,196);text-dec=
oration:none;background:transparent">-1340,6</a> <a href=3D"http://git.lttn=
g.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Dd82=
a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc=
6a905f80#l1340" class=3D"" style=3D"margin:0px;padding:0px;border:0px;outli=
ne:none;vertical-align:baseline;color:rgb(65,131,196);text-decoration:none;=
background:transparent">+1340,18</a> @@</span><span class=3D"" style=3D"mar=
gin:0px;padding:0px;border:0px;outline:0px;vertical-align:baseline;backgrou=
nd:transparent">=C2=A0int=C2=A0relay_close_stream(struct=C2=A0lttcomm_relay=
d_hdr=C2=A0*recv_hdr,</span></div><div class=3D"" style=3D"margin:0px;paddi=
ng:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-f=
amily:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre=
-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(248,24=
8,248)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0session-&gt;stream_=
count--;</div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;ou=
tline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;=
Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,=
0);line-height:18.2000007629395px;background:rgb(248,248,248)">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(session-&gt;stream_count=C2=A0&g=
t;=3D=C2=A00);</div><div class=3D"" style=3D"margin:0px;padding:0px;border:=
0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas=
,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rg=
b(0,0,0);line-height:18.2000007629395px;background:rgb(248,248,248)">=C2=A0=
</div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0p=
x;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstrea=
m Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-=
height:18.2000007629395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/*</div><div class=3D"" style=3D"margin:0px;padding=
:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-fam=
ily:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-w=
rap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,255,=
221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0Remove=C2=A0t=
he=C2=A0stream=C2=A0from=C2=A0the=C2=A0connection=C2=A0recv=C2=A0list=C2=A0=
since=C2=A0we=C2=A0are=C2=A0about=C2=A0to</div><div class=3D"" style=3D"mar=
gin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:ba=
seline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;wh=
ite-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgrou=
nd:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=
=A0flag=C2=A0it=C2=A0invalid=C2=A0and=C2=A0thus=C2=A0might=C2=A0be=C2=A0fre=
ed.=C2=A0This=C2=A0has=C2=A0to=C2=A0be=C2=A0done=C2=A0here=C2=A0since</div>=
<div class=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;font=
-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera=
 Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height=
:18.2000007629395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0only=C2=A0the=C2=A0control=C2=A0thread=C2=A0=
can=C2=A0do=C2=A0actions=C2=A0on=C2=A0that=C2=A0list.</div><div class=3D"" =
style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;verti=
cal-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,=
monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.200000762939=
5px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0*</div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;=
outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#3=
9;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,=
0,0);line-height:18.2000007629395px;background:rgb(221,255,221)">+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0Note=C2=A0that=C2=A0this=C2=
=A0stream=C2=A0might=C2=A0NOT=C2=A0be=C2=A0in=C2=A0the=C2=A0list=C2=A0but=
=C2=A0we=C2=A0have=C2=A0to=C2=A0try=C2=A0to</div><div class=3D"" style=3D"m=
argin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:=
baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;=
white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgr=
ound:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=
=C2=A0remove=C2=A0it=C2=A0here=C2=A0else=C2=A0this=C2=A0can=C2=A0race=C2=A0=
with=C2=A0the=C2=A0stream=C2=A0destruction=C2=A0freeing</div><div class=3D"=
" style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;ver=
tical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39=
;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629=
395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0*=C2=A0the=C2=A0object=C2=A0and=C2=A0the=C2=A0connection=C2=A0dest=
roy=C2=A0doing=C2=A0a=C2=A0use=C2=A0after=C2=A0free=C2=A0when</div><div cla=
ss=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13=
px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mo=
no&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000=
007629395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0*=C2=A0deleting=C2=A0the=C2=A0remaining=C2=A0nodes=C2=A0in=
=C2=A0this=C2=A0list.</div><div class=3D"" style=3D"margin:0px;padding:0px;=
border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:C=
onsolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;c=
olor:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,255,221)"=
>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/</div><div class=3D"" s=
tyle=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertic=
al-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,m=
onospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395=
px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cds_list_del(&amp;stream-&gt;recv_list);</div><div class=3D"" style=3D"marg=
in:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:bas=
eline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;whi=
te-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgroun=
d:rgb(221,255,221)">+</div><div class=3D"" style=3D"margin:0px;padding:0px;=
border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:C=
onsolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;c=
olor:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(248,248,248)"=
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0Check=C2=A0if=C2=
=A0we=C2=A0can=C2=A0close=C2=A0it=C2=A0or=C2=A0else=C2=A0the=C2=A0data=C2=
=A0will=C2=A0do=C2=A0it.=C2=A0*/</div><div class=3D"" style=3D"margin:0px;p=
adding:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;fo=
nt-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space=
:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(24=
8,248,248)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0try_close_strea=
m(session,=C2=A0stream);</div></div><div class=3D"" style=3D"margin:0px;pad=
ding:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font=
-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:p=
re-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(248,=
248,248)"><br></div><div class=3D"" style=3D"margin:0px;padding:0px;border:=
0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas=
,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rg=
b(0,0,0);line-height:18.2000007629395px;background:rgb(248,248,248)"><br></=
div><div class=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;=
font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream =
Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-he=
ight:18.2000007629395px;background:rgb(248,248,248)"><br></div><div class=
=3D"" style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px=
;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono=
&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.200000=
7629395px;background:rgb(248,248,248)"><br></div><div class=3D"" style=3D"m=
argin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:=
baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;=
white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgr=
ound:rgb(248,248,248)"><br></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">On Mon, Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie Ga=
larneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.=
com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Do you have a specific =
changeset in mind when you say you applied the changes mentioned in that th=
read?<div><br></div><div>Do you simply revert the following commit?</div><d=
iv><a href=3D"https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f8=
6ef451e4c0331445346b15f" target=3D"_blank">https://github.com/lttng/lttng-t=
ools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f</a></div><div><br></di=
v><div>Thanks,</div><div>J=C3=A9r=C3=A9mie<div><div class=3D"h5"><br><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Jul 11, 2015 at=
 3:26 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gma=
il.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padd=
ing-left:1ex"><div dir=3D"ltr">To try this fix, I also needed the changes t=
alked about in=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2=
015-July/024689.html" target=3D"_blank">http://lists.lttng.org/pipermail/lt=
tng-dev/2015-July/024689.html</a> , otherwise, I would see relayd coring.<d=
iv>Once I took them I could see that the soft hang issue was no longer repr=
oducible.=C2=A0</div><div><br></div><div>Thanks for helping.</div></div><di=
v><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Ju=
l 8, 2015 at 9:49 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:ar=
avind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div dir=3D"ltr">Sure, I will try the fix and upd=
ate.</div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_b=
lank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><div dir=3D"ltr">Would you mind testing Mathieu&#39;s patch?<div><br></=
div><div>I have rebased it on stable-2.6:</div><div><div>git clone <a href=
=3D"https://github.com/jgalar/lttng-tools.git" target=3D"_blank">https://gi=
thub.com/jgalar/lttng-tools.git</a> -b hang-fix<br></div></div><div><br></d=
iv><div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div></div><div><=
br></div></div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <span =
dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D=
"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-lef=
t:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>What do you observe when thi=
s happens? Does the session daemon become unresponsive?</div><div><br></div=
><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote"><div><div>On Wed, May 27, 2015 at 6:19 AM, Aravind HT <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank=
">aravind.ht@gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex=
"><div><div><div dir=3D"ltr">Request someone to kindly help with this. Bloc=
ked at this point, unable to continue as any application crash leads to ltt=
ng not working.<div><br></div><div>Thanks,</div><div>Aravind.</div></div><d=
iv><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, M=
ay 21, 2015 at 12:18 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto=
:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div dir=3D"ltr"><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px">Hi,</p><p class=3D"MsoNormal" style=3D"fo=
nt-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">I have recently started trying lttng 2.6 for a few=
 applications on my Ubuntu 12.04 and I noticed that the health check on ses=
siond and consumerd failed soon after starting the session.</p><p class=3D"=
MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">On investigating, I found that=
 thread_manage_consumer() had exited causing an overall health check failur=
e.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p=
><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Here are the=
 sequence of steps that I found contributed to=C2=A0<b>thread_manage_consum=
er()</b>=C2=A0exiting.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000=
001907349px"></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349=
px"><br></p><p style=3D"font-size:12.8000001907349px">1.<span style=3D"font=
-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() =
: 1558 , ust_app_unregister(pollfd)</b>=C2=A0is being called. This happens =
when there is an error detected by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&am=
p;events, i)</b></p><p style=3D"font-size:12.8000001907349px">My initial gu=
ess here is that as one of my apps has crashed, producing a=C2=A0<b>LPOLLER=
R | LPOLLHUP | LPOLLRDHUP=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=
=C2=A0causing=C2=A0<b>ust_app_unregister()</b>=C2=A0to be called for that a=
pp.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font=
-size:12.8000001907349px">2.<span style=3D"font-stretch:normal;font-size:7p=
t;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0</span>In=C2=A0<b>ust_app_unregister():3154 , close_metadata(regis=
try, ua_sess-&gt;consumer)=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;met=
adata_closed =3D 1=C2=A0</b>is set<b>.</b></p><p style=3D"font-size:12.8000=
001907349px;text-indent:0.5in">=C2=A0</p><p style=3D"font-size:12.800000190=
7349px;text-indent:0.5in">(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>als=
o calls<b>=C2=A0consumer_close_metadata()=C2=A0</b>which sends<b>=C2=A0LTTN=
G_CONSUMER_CLOSE_METADATA=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the=
 consumerd to stop it from further dealing with the concerned app. Somehow =
this doesn=E2=80=99t seem to help<b>.</b></p><p style=3D"font-size:12.80000=
01907349px"><b>=C2=A0</b></p><p style=3D"font-size:12.8000001907349px">3.<s=
pan style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New R=
oman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see tha=
t the=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0for some reason has ig=
nored the above 2.a and gets to do request/reply for that app by calling<b>=
ust_consumer_metadata_request():491 -&gt; ust_app_push_metadat(ust_reg, soc=
ket,1)=C2=A0</b>which at line 460 checks for=C2=A0<b>registry-&gt;metadata_=
closed</b>=C2=A0and returns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"Ms=
oNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-=
size:12.8000001907349px">4.<span style=3D"font-stretch:normal;font-size:7pt=
;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0</span>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the=
 way back up to=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0at which poi=
nt=C2=A0<b>thread_manage_consumer()</b>=C2=A0decides to exit causing health=
_check() to fail.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p=
 class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">So it looks like u=
nder some scenario, an application crash could cause the lttng some problem=
s.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0<=
/p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I think a =
possible fix for this scenario, is to instead of 4, send an=C2=A0<b>ERROR</=
b>=C2=A0message back to=C2=A0<b>consumerd()</b>=C2=A0. This could be done f=
rom=C2=A0<b>ust_consumer_metadata_request()</b>=C2=A0call. Can someone plea=
se let me know if this is correct and shed more light on the issue ?</p><p =
class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p cla=
ss=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Please forgive if the=
re are any guideline omissions for posting here from my part. This is my fi=
rst post.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=
<br></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Regar=
ds,</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Aravin=
d.</p></div>
</blockquote></div><br></div>
</div></div><br></div></div>_______________________________________________=
<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9=
r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a></div>
</div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.=
efficios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div></div></div></div></div>
</blockquote></div><br></div>

--047d7b3a81feeedad3051ac62747--


--===============1425057862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1425057862==--
