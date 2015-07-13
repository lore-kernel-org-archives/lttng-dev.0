From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Tue, 14 Jul 2015 00:59:16 +0530
Message-ID: <CACd+_b6Dz8eriOnPm9n5Ht8f1DJy-Cy3DE80NBCd27WxtDZdUQ__5577.23117894984$1436815830$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
 <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
 <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA@mail.gmail.com>
 <CA+jJMxtyOqTDSh3iphDAE4qPx0+C8jJ3Txi1j+ouxHx0guuXng@mail.gmail.com>
 <CACd+_b5dwMRdR8wjzG0S5wpwtuB+qx_Q4Y0RHA2GDw7ZZgny+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0689982131=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZEjPn-0001bZ-2M
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 15:29:28 -0400
Received: by lagw2 with SMTP id w2so20453749lag.3
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2015 12:29:16 -0700 (PDT)
In-Reply-To: <CACd+_b5dwMRdR8wjzG0S5wpwtuB+qx_Q4Y0RHA2GDw7ZZgny+A@mail.gmail.com>
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

--===============0689982131==
Content-Type: multipart/alternative; boundary=001a11349a2ec19780051ac6bce6

--001a11349a2ec19780051ac6bce6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cds_list_del(&stream->recv_list) definitely needs to be called from
relay_close_stream() else conn->recv_head will continue to have a stale
pointer(for streams that got closed) until
the entire connection is destroyed, and conversely,
connection_destruction() means destroying the conn->recv_head list which
means iterating/removing entries of streams ( some of them could be stale,
if relay_close_stream() does not do cds_list_del() ) and in which case,
cds_list_del(&stream->recv_list) needs to be called also.

So removing either of them, I think, is not the good and in this case,
https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03314=
45346b15f
could be reverted


 *** However *** ,
there could also be a synchronization issue if relay_close_stream() and
connection_destroy() can happen concurrently if these calls are not
serialized ( stream->recv_list being accessed from two contexts ), need to
verify this before reverting
https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03314=
45346b15f


I also do not know the kind of issues being seen/details to prompt the
reversal of
http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80



On Tue, Jul 14, 2015 at 12:17 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> The specific change in
> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54=
ced9e4d0d03b865bb7fc6a905f80
> that I need is for cds_list_del(&stream->recv_list); to be called.
> Below is the patch extract.
>
> diff --git a/src/bin/lttng-relayd/main.c
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
> b/src/bin/lttng-relayd/main.c
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80>
>
> index a93151a
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
> ..d82a341
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80>
> 100644 (file)
> --- a/src/bin/lttng-relayd/main.c
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
> +++ b/src/bin/lttng-relayd/main.c
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80>
> @@ -1340,6
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc#l1340>
> +1340,18
> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-rel=
ayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ce=
d9e4d0d03b865bb7fc6a905f80#l1340>
> @@ int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
>         session->stream_count--;
>         assert(session->stream_count >=3D 0);
>
> +       /*
>
> +        * Remove the stream from the connection recv list since we are a=
bout to
>
> +        * flag it invalid and thus might be freed. This has to be done h=
ere since
> +        * only the control thread can do actions on that list.
> +        *
>
> +        * Note that this stream might NOT be in the list but we have to =
try to
>
> +        * remove it here else this can race with the stream destruction =
freeing
>
> +        * the object and the connection destroy doing a use after free w=
hen
> +        * deleting the remaining nodes in this list.
> +        */
> +       cds_list_del(&stream->recv_list);
> +
>         /* Check if we can close it or else the data will do it. */
>         try_close_stream(session, stream);
>
>
>
>
>
>
> On Mon, Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> Do you have a specific changeset in mind when you say you applied the
>> changes mentioned in that thread?
>>
>> Do you simply revert the following commit?
>>
>> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03=
31445346b15f
>>
>> Thanks,
>> J=C3=A9r=C3=A9mie
>>
>>
>> On Sat, Jul 11, 2015 at 3:26 AM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>>
>>> To try this fix, I also needed the changes talked about in
>>> http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html ,
>>> otherwise, I would see relayd coring.
>>> Once I took them I could see that the soft hang issue was no longer
>>> reproducible.
>>>
>>> Thanks for helping.
>>>
>>> On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>>>
>>>> Sure, I will try the fix and update.
>>>>
>>>> On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
>>>> jeremie.galarneau@efficios.com> wrote:
>>>>
>>>>> Would you mind testing Mathieu's patch?
>>>>>
>>>>> I have rebased it on stable-2.6:
>>>>> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>>>>>
>>>>> Thanks,
>>>>> J=C3=A9r=C3=A9mie=EF=BF=BC
>>>>>
>>>>>
>>>>> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
>>>>> jeremie.galarneau@efficios.com> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> What do you observe when this happens? Does the session daemon becom=
e
>>>>>> unresponsive?
>>>>>>
>>>>>> J=C3=A9r=C3=A9mie
>>>>>>
>>>>>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com>
>>>>>> wrote:
>>>>>>
>>>>>>> Request someone to kindly help with this. Blocked at this point,
>>>>>>> unable to continue as any application crash leads to lttng not work=
ing.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Aravind.
>>>>>>>
>>>>>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I have recently started trying lttng 2.6 for a few applications on
>>>>>>>> my Ubuntu 12.04 and I noticed that the health check on sessiond an=
d
>>>>>>>> consumerd failed soon after starting the session.
>>>>>>>>
>>>>>>>>
>>>>>>>> On investigating, I found that thread_manage_consumer() had exited
>>>>>>>> causing an overall health check failure.
>>>>>>>>
>>>>>>>>
>>>>>>>> Here are the sequence of steps that I found contributed to
>>>>>>>> *thread_manage_consumer()* exiting.
>>>>>>>>
>>>>>>>>
>>>>>>>> 1.       In *thread_manage_apps() : 1558 ,
>>>>>>>> ust_app_unregister(pollfd)* is being called. This happens when
>>>>>>>> there is an error detected by *revents =3D LTTNG_POLL_GETEV(&event=
s,
>>>>>>>> i)*
>>>>>>>>
>>>>>>>> My initial guess here is that as one of my apps has crashed,
>>>>>>>> producing a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated for
>>>>>>>> *epoll()* causing *ust_app_unregister()* to be called for that app=
.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>>>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is
>>>>>>>> set*.*
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> (2.a) Note:* close_metadata() *also calls
>>>>>>>> * consumer_close_metadata() *which sends
>>>>>>>> * LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>>>>>>> consumerd to stop it from further dealing with the concerned app. =
Somehow
>>>>>>>> this doesn=E2=80=99t seem to help*.*
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for
>>>>>>>> some reason has ignored the above 2.a and gets to do request/reply=
 for that
>>>>>>>> app by calling*ust_consumer_metadata_request():491 ->
>>>>>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks
>>>>>>>> for *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up =
to
>>>>>>>> *thread_manage_consumer():1353* at which point
>>>>>>>> *thread_manage_consumer()* decides to exit causing health_check()
>>>>>>>> to fail.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> So it looks like under some scenario, an application crash could
>>>>>>>> cause the lttng some problems.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> I think a possible fix for this scenario, is to instead of 4, send
>>>>>>>> an *ERROR* message back to *consumerd()* . This could be done from
>>>>>>>> *ust_consumer_metadata_request()* call. Can someone please let me
>>>>>>>> know if this is correct and shed more light on the issue ?
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Please forgive if there are any guideline omissions for posting
>>>>>>>> here from my part. This is my first post.
>>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>
>>>>>>>> Aravind.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org
>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>>> EfficiOS Inc.
>>>>>> http://www.efficios.com
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>> EfficiOS Inc.
>>>>> http://www.efficios.com
>>>>>
>>>>
>>>>
>>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--001a11349a2ec19780051ac6bce6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span class=3D"" style=3D"color:rgb(0,134,179);font-f=
amily:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:=
12px;line-height:16.7999992370605px;white-space:pre;background-color:rgb(25=
5,236,236)">cds_list_del</span><span style=3D"color:rgb(51,51,51);font-fami=
ly:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12p=
x;line-height:16.7999992370605px;white-space:pre;background-color:rgb(255,2=
36,236)">(&amp;stream-&gt;recv_list) definitely needs to be called from rel=
ay_close_stream() else </span><span style=3D"color:rgb(51,51,51);font-famil=
y:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px=
;line-height:16.7999992370605px;white-space:pre;background-color:rgb(255,23=
6,236)">conn-&gt;recv_head will continue to have a stale pointer(for stream=
s that got closed) until=C2=A0</span></div><div><span style=3D"color:rgb(51=
,51,51);font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monosp=
ace;font-size:12px;line-height:16.7999992370605px;white-space:pre;backgroun=
d-color:rgb(255,236,236)">the entire connection is destroyed, and conversel=
y, connection_destruction() means destroying the conn-&gt;recv_head list wh=
ich means iterating/removing entries of streams ( some of them could be sta=
le,</span></div><div><span style=3D"color:rgb(51,51,51);font-family:Consola=
s,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-hei=
ght:16.7999992370605px;white-space:pre;background-color:rgb(255,236,236)">i=
f relay_close_stream() does not do cds_list_del() ) and in which case, </sp=
an><span class=3D"" style=3D"color:rgb(0,134,179);font-family:Consolas,&#39=
;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-height:16=
.7999992370605px;white-space:pre;background-color:rgb(255,236,236)">cds_lis=
t_del</span><span style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;Li=
beration Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-height:16.79=
99992370605px;white-space:pre;background-color:rgb(255,236,236)">(&amp;stre=
am-&gt;recv_list) needs to be called also.</span></div><div><span style=3D"=
color:rgb(51,51,51);font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Co=
urier,monospace;font-size:12px;line-height:16.7999992370605px;white-space:p=
re;background-color:rgb(255,236,236)"><br></span></div><div><font color=3D"=
#333333" face=3D"Consolas, Liberation Mono, Menlo, Courier, monospace"><spa=
n style=3D"font-size:12px;line-height:16.7999992370605px;white-space:pre;ba=
ckground-color:rgb(255,236,236)">So removing either of them, I think, is no=
t the good and in this case, </span></font><a href=3D"https://github.com/lt=
tng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f">https://gi=
thub.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f<=
/a> could be reverted</div><div><br></div><div><br></div><div>=C2=A0*** How=
ever *** ,=C2=A0</div><div>there could also be a synchronization issue if r=
elay_close_stream() and connection_destroy() can happen concurrently if the=
se calls are not serialized ( stream-&gt;recv_list being accessed from two =
contexts ), need to verify this before reverting <a href=3D"https://github.=
com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f">http=
s://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c033144534=
6b15f</a> =C2=A0</div><div><br></div><div>I also do not know the kind of is=
sues being seen/details to prompt the reversal of=C2=A0<a href=3D"http://gi=
t.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03=
b865bb7fc6a905f80">http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff=
;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80</a></div><div><br></div><div>=
<br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, Jul 14, 2015 at 12:17 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=
=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">The s=
pecific change in=C2=A0<a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git=
;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" target=3D"_bl=
ank">http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1=
d54ced9e4d0d03b865bb7fc6a905f80</a><div>that I need is for=C2=A0<span style=
=3D"color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39=
;,monospace;font-size:13px;line-height:18.2000007629395px;white-space:pre-w=
rap;background-color:rgb(221,255,221)">cds_list_del(&amp;stream-&gt;recv_li=
st); to be called.=C2=A0</span></div><div><span style=3D"color:rgb(0,0,0);f=
ont-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;font-size:=
13px;line-height:18.2000007629395px;white-space:pre-wrap;background-color:r=
gb(221,255,221)">Below is the patch extract.</span></div><div><span style=
=3D"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Ver=
a Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-space:pre-w=
rap;background-color:rgb(234,242,245)"><br></span></div><div><span style=3D=
"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Vera S=
ans Mono&#39;,monospace;line-height:18.2000007629395px;white-space:pre-wrap=
;background-color:rgb(234,242,245)">diff --git </span><a href=3D"http://git=
.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=
=3Da93151ac47f560875f07c9cbf113225f9dd892cc" style=3D"font-size:13px;margin=
:0px;padding:0px;border:0px;outline:none;vertical-align:baseline;color:rgb(=
65,131,196);text-decoration:none;font-family:Consolas,&#39;Bitstream Vera S=
ans Mono&#39;,monospace;line-height:18.2000007629395px;white-space:pre-wrap=
;background:transparent" target=3D"_blank">a/src/bin/lttng-relayd/main.c</a=
><span style=3D"font-size:13px;color:rgb(0,0,0);font-family:Consolas,&#39;B=
itstream Vera Sans Mono&#39;,monospace;line-height:18.2000007629395px;white=
-space:pre-wrap;background-color:rgb(234,242,245)"> </span><a href=3D"http:=
//git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main=
.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d0d0=
3b865bb7fc6a905f80" style=3D"font-size:13px;margin:0px;padding:0px;border:0=
px;outline:none;vertical-align:baseline;color:rgb(65,131,196);text-decorati=
on:none;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;l=
ine-height:18.2000007629395px;white-space:pre-wrap;background:transparent" =
target=3D"_blank">b/src/bin/lttng-relayd/main.c</a></div><div><br></div><di=
v><div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13p=
x;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mon=
o&#39;,monospace;width:1480.5625px;white-space:pre-wrap;color:rgb(0,0,0);li=
ne-height:18.2000007629395px;background:rgb(248,248,248)">index <a href=3D"=
http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd=
/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc" style=3D"margin:0px;p=
adding:0px;border:0px;outline:none;vertical-align:baseline;color:rgb(65,131=
,196);text-decoration:none;background:transparent" target=3D"_blank">a93151=
a</a>..<a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsr=
c/bin/lttng-relayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=
=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" style=3D"margin:0px;padding:0p=
x;border:0px;outline:none;vertical-align:baseline;color:rgb(65,131,196);tex=
t-decoration:none;background:transparent" target=3D"_blank">d82a341</a> 100=
644<span style=3D"margin:0px;padding:0px;border:0px;outline:0px;vertical-al=
ign:baseline;background:transparent"> (file)</span><br>
</div><div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size=
:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans=
 Mono&#39;,monospace;white-space:pre-wrap;color:rgb(170,0,0);line-height:18=
.2000007629395px;background:rgb(248,248,248)">--- a/<a href=3D"http://git.l=
ttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3D=
a93151ac47f560875f07c9cbf113225f9dd892cc" style=3D"margin:0px;padding:0px;b=
order:0px;outline:none;vertical-align:baseline;color:rgb(170,0,0);text-deco=
ration:none;background:transparent" target=3D"_blank">src/bin/lttng-relayd/=
main.c</a></div><div style=3D"margin:0px;padding:0px;border:0px;outline:0px=
;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream=
 Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,112,0);line=
-height:18.2000007629395px;background:rgb(248,248,248)">+++ b/<a href=3D"ht=
tp://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/m=
ain.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d=
0d03b865bb7fc6a905f80" style=3D"margin:0px;padding:0px;border:0px;outline:n=
one;vertical-align:baseline;color:rgb(0,112,0);text-decoration:none;backgro=
und:transparent" target=3D"_blank">src/bin/lttng-relayd/main.c</a></div><di=
v style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;ver=
tical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39=
;,monospace;color:rgb(153,153,153);white-space:pre-wrap;line-height:18.2000=
007629395px;background:rgb(234,242,245)"><span style=3D"margin:0px;padding:=
0px;border:0px;outline:0px;vertical-align:baseline;background:transparent">=
@@ <a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bi=
n/lttng-relayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc#l1340" s=
tyle=3D"margin:0px;padding:0px;border:0px;outline:none;vertical-align:basel=
ine;color:rgb(65,131,196);text-decoration:none;background:transparent" targ=
et=3D"_blank">-1340,6</a> <a href=3D"http://git.lttng.org/?p=3Dlttng-tools.=
git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf=
0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80#l1340" style=
=3D"margin:0px;padding:0px;border:0px;outline:none;vertical-align:baseline;=
color:rgb(65,131,196);text-decoration:none;background:transparent" target=
=3D"_blank">+1340,18</a> @@</span><span style=3D"margin:0px;padding:0px;bor=
der:0px;outline:0px;vertical-align:baseline;background:transparent">=C2=A0i=
nt=C2=A0relay_close_stream(struct=C2=A0lttcomm_relayd_hdr=C2=A0*recv_hdr,</=
span></div><div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font=
-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera=
 Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height=
:18.2000007629395px;background:rgb(248,248,248)">=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0session-&gt;stream_count--;</div><div style=3D"marg=
in:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:bas=
eline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;whi=
te-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgroun=
d:rgb(248,248,248)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0assert(=
session-&gt;stream_count=C2=A0&gt;=3D=C2=A00);</div><div style=3D"margin:0p=
x;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline=
;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-sp=
ace:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb=
(248,248,248)">=C2=A0</div><div style=3D"margin:0px;padding:0px;border:0px;=
outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#3=
9;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,=
0,0);line-height:18.2000007629395px;background:rgb(221,255,221)">+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*</div><div style=3D"margin:0px;padding:0=
px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-famil=
y:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wra=
p;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,255,22=
1)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0Remove=C2=A0the=
=C2=A0stream=C2=A0from=C2=A0the=C2=A0connection=C2=A0recv=C2=A0list=C2=A0si=
nce=C2=A0we=C2=A0are=C2=A0about=C2=A0to</div><div style=3D"margin:0px;paddi=
ng:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-f=
amily:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre=
-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,25=
5,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0flag=C2=A0i=
t=C2=A0invalid=C2=A0and=C2=A0thus=C2=A0might=C2=A0be=C2=A0freed.=C2=A0This=
=C2=A0has=C2=A0to=C2=A0be=C2=A0done=C2=A0here=C2=A0since</div><div style=3D=
"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-alig=
n:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospac=
e;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;back=
ground:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=
=C2=A0only=C2=A0the=C2=A0control=C2=A0thread=C2=A0can=C2=A0do=C2=A0actions=
=C2=A0on=C2=A0that=C2=A0list.</div><div style=3D"margin:0px;padding:0px;bor=
der:0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:Cons=
olas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;colo=
r:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,255,221)">+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*</div><div style=3D"margin=
:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:basel=
ine;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white=
-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:=
rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0N=
ote=C2=A0that=C2=A0this=C2=A0stream=C2=A0might=C2=A0NOT=C2=A0be=C2=A0in=C2=
=A0the=C2=A0list=C2=A0but=C2=A0we=C2=A0have=C2=A0to=C2=A0try=C2=A0to</div><=
div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;v=
ertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#=
39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.20000076=
29395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0*=C2=A0remove=C2=A0it=C2=A0here=C2=A0else=C2=A0this=C2=A0can=C2=
=A0race=C2=A0with=C2=A0the=C2=A0stream=C2=A0destruction=C2=A0freeing</div><=
div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;v=
ertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#=
39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.20000076=
29395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0*=C2=A0the=C2=A0object=C2=A0and=C2=A0the=C2=A0connection=C2=A0d=
estroy=C2=A0doing=C2=A0a=C2=A0use=C2=A0after=C2=A0free=C2=A0when</div><div =
style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;verti=
cal-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,=
monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.200000762939=
5px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0*=C2=A0deleting=C2=A0the=C2=A0remaining=C2=A0nodes=C2=A0in=C2=A0th=
is=C2=A0list.</div><div style=3D"margin:0px;padding:0px;border:0px;outline:=
0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstr=
eam Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);lin=
e-height:18.2000007629395px;background:rgb(221,255,221)">+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/</div><div style=3D"margin:0px;padding:0=
px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-famil=
y:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wra=
p;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(221,255,22=
1)">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cds_list_del(&amp;stream-&gt=
;recv_list);</div><div style=3D"margin:0px;padding:0px;border:0px;outline:0=
px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bitstre=
am Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line=
-height:18.2000007629395px;background:rgb(221,255,221)">+</div><div style=
=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-a=
lign:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monos=
pace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;b=
ackground:rgb(248,248,248)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/*=C2=A0Check=C2=A0if=C2=A0we=C2=A0can=C2=A0close=C2=A0it=C2=A0or=C2=A0e=
lse=C2=A0the=C2=A0data=C2=A0will=C2=A0do=C2=A0it.=C2=A0*/</div><div style=
=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-a=
lign:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monos=
pace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;b=
ackground:rgb(248,248,248)">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0try_close_stream(session,=C2=A0stream);</div></div><div style=3D"margin:=
0px;padding:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseli=
ne;font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-=
space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:r=
gb(248,248,248)"><br></div><div style=3D"margin:0px;padding:0px;border:0px;=
outline:0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#3=
9;Bitstream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,=
0,0);line-height:18.2000007629395px;background:rgb(248,248,248)"><br></div>=
<div style=3D"margin:0px;padding:0px;border:0px;outline:0px;font-size:13px;=
vertical-align:baseline;font-family:Consolas,&#39;Bitstream Vera Sans Mono&=
#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007=
629395px;background:rgb(248,248,248)"><br></div><div style=3D"margin:0px;pa=
dding:0px;border:0px;outline:0px;font-size:13px;vertical-align:baseline;fon=
t-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;white-space:=
pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;background:rgb(248=
,248,248)"><br></div><div style=3D"margin:0px;padding:0px;border:0px;outlin=
e:0px;font-size:13px;vertical-align:baseline;font-family:Consolas,&#39;Bits=
tream Vera Sans Mono&#39;,monospace;white-space:pre-wrap;color:rgb(0,0,0);l=
ine-height:18.2000007629395px;background:rgb(248,248,248)"><br></div></div>=
<div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Mon, Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie G=
alarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios=
.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Do you have a specific=
 changeset in mind when you say you applied the changes mentioned in that t=
hread?<div><br></div><div>Do you simply revert the following commit?</div><=
div><a href=3D"https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f=
86ef451e4c0331445346b15f" target=3D"_blank">https://github.com/lttng/lttng-=
tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f</a></div><div><br></d=
iv><div>Thanks,</div><div>J=C3=A9r=C3=A9mie<div><div><br><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Sat, Jul 11, 2015 at 3:26 AM, Ar=
avind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" targ=
et=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;=
border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex=
"><div dir=3D"ltr">To try this fix, I also needed the changes talked about =
in=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-July/024=
689.html" target=3D"_blank">http://lists.lttng.org/pipermail/lttng-dev/2015=
-July/024689.html</a> , otherwise, I would see relayd coring.<div>Once I to=
ok them I could see that the soft hang issue was no longer reproducible.=C2=
=A0</div><div><br></div><div>Thanks for helping.</div></div><div><div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jul 8, 2015 at=
 9:49 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gma=
il.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padd=
ing-left:1ex"><div dir=3D"ltr">Sure, I will try the fix and update.</div><d=
iv><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, J=
ul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<=
a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremie.=
galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=
=3D"ltr">Would you mind testing Mathieu&#39;s patch?<div><br></div><div>I h=
ave rebased it on stable-2.6:</div><div><div>git clone <a href=3D"https://g=
ithub.com/jgalar/lttng-tools.git" target=3D"_blank">https://github.com/jgal=
ar/lttng-tools.git</a> -b hang-fix<br></div></div><div><br></div><div><div>=
Thanks,</div><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div></div><div><br></div></di=
v><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mo=
n, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&=
lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jere=
mie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div d=
ir=3D"ltr">Hi,<div><br></div><div>What do you observe when this happens? Do=
es the session daemon become unresponsive?</div><div><br></div><div>J=C3=A9=
r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote"><div><div>On Wed, May 27, 2015 at 6:19 AM, Aravind HT <span dir=3D"ltr=
">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@=
gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div><div><=
div dir=3D"ltr">Request someone to kindly help with this. Blocked at this p=
oint, unable to continue as any application crash leads to lttng not workin=
g.<div><br></div><div>Thanks,</div><div>Aravind.</div></div><div><div><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 21, 2015 a=
t 12:18 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@g=
mail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pa=
dding-left:1ex"><div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-size:=
12.8000001907349px">Hi,</p><p class=3D"MsoNormal" style=3D"font-size:12.800=
0001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.800000=
1907349px">I have recently started trying lttng 2.6 for a few applications =
on my Ubuntu 12.04 and I noticed that the health check on sessiond and cons=
umerd failed soon after starting the session.</p><p class=3D"MsoNormal" sty=
le=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D=
"font-size:12.8000001907349px">On investigating, I found that thread_manage=
_consumer() had exited causing an overall health check failure.</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"M=
soNormal" style=3D"font-size:12.8000001907349px">Here are the sequence of s=
teps that I found contributed to=C2=A0<b>thread_manage_consumer()</b>=C2=A0=
exiting.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><=
/p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p=
 style=3D"font-size:12.8000001907349px">1.<span style=3D"font-stretch:norma=
l;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() : 1558 , ust=
_app_unregister(pollfd)</b>=C2=A0is being called. This happens when there i=
s an error detected by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&amp;events, i)=
</b></p><p style=3D"font-size:12.8000001907349px">My initial guess here is =
that as one of my apps has crashed, producing a=C2=A0<b>LPOLLERR | LPOLLHUP=
 | LPOLLRDHUP=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=C2=A0causing=
=C2=A0<b>ust_app_unregister()</b>=C2=A0to be called for that app.</p><p sty=
le=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8000=
001907349px">2.<span style=3D"font-stretch:normal;font-size:7pt;font-family=
:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</spa=
n>In=C2=A0<b>ust_app_unregister():3154 , close_metadata(registry, ua_sess-&=
gt;consumer)=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;metadata_closed =
=3D 1=C2=A0</b>is set<b>.</b></p><p style=3D"font-size:12.8000001907349px;t=
ext-indent:0.5in">=C2=A0</p><p style=3D"font-size:12.8000001907349px;text-i=
ndent:0.5in">(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>also calls<b>=C2=
=A0consumer_close_metadata()=C2=A0</b>which sends<b>=C2=A0LTTNG_CONSUMER_CL=
OSE_METADATA=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the consumerd to=
 stop it from further dealing with the concerned app. Somehow this doesn=E2=
=80=99t seem to help<b>.</b></p><p style=3D"font-size:12.8000001907349px"><=
b>=C2=A0</b></p><p style=3D"font-size:12.8000001907349px">3.<span style=3D"=
font-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see that the=C2=A0=
<b>thread_manage_consumer():1353</b>=C2=A0for some reason has ignored the a=
bove 2.a and gets to do request/reply for that app by calling<b>ust_consume=
r_metadata_request():491 -&gt; ust_app_push_metadat(ust_reg, socket,1)=C2=
=A0</b>which at line 460 checks for=C2=A0<b>registry-&gt;metadata_closed</b=
>=C2=A0and returns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"MsoNormal" =
style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8=
000001907349px">4.<span style=3D"font-stretch:normal;font-size:7pt;font-fam=
ily:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</=
span>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the way back u=
p to=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0at which point=C2=A0<b>=
thread_manage_consumer()</b>=C2=A0decides to exit causing health_check() to=
 fail.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"M=
soNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoN=
ormal" style=3D"font-size:12.8000001907349px">So it looks like under some s=
cenario, an application crash could cause the lttng some problems.</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I think a possible fi=
x for this scenario, is to instead of 4, send an=C2=A0<b>ERROR</b>=C2=A0mes=
sage back to=C2=A0<b>consumerd()</b>=C2=A0. This could be done from=C2=A0<b=
>ust_consumer_metadata_request()</b>=C2=A0call. Can someone please let me k=
now if this is correct and shed more light on the issue ?</p><p class=3D"Ms=
oNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNorma=
l" style=3D"font-size:12.8000001907349px">Please forgive if there are any g=
uideline omissions for posting here from my part. This is my first post.</p=
><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p c=
lass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Regards,</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Aravind.</p></div>
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
</div></div></blockquote></div><br></div>

--001a11349a2ec19780051ac6bce6--


--===============0689982131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0689982131==--
