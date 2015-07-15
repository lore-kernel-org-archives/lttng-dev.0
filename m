From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Wed, 15 Jul 2015 19:30:54 +0530
Message-ID: <CACd+_b4ONWFKNjP+GkPTryzpLQFA1gVwNY3o4xiYpgibB+WvUg__49382.2477794767$1436968935$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
 <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
 <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA@mail.gmail.com>
 <CA+jJMxtyOqTDSh3iphDAE4qPx0+C8jJ3Txi1j+ouxHx0guuXng@mail.gmail.com>
 <CACd+_b5dwMRdR8wjzG0S5wpwtuB+qx_Q4Y0RHA2GDw7ZZgny+A@mail.gmail.com>
 <CACd+_b6Dz8eriOnPm9n5Ht8f1DJy-Cy3DE80NBCd27WxtDZdUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0251703550=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZFNF7-000681-3Y
 for lttng-dev@lists.lttng.org; Wed, 15 Jul 2015 10:01:08 -0400
Received: by lbbpo10 with SMTP id po10so25378486lbb.3
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 07:00:55 -0700 (PDT)
In-Reply-To: <CACd+_b6Dz8eriOnPm9n5Ht8f1DJy-Cy3DE80NBCd27WxtDZdUQ@mail.gmail.com>
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

--===============0251703550==
Content-Type: multipart/alternative; boundary=089e0160bdaa285582051aea620e

--089e0160bdaa285582051aea620e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have gone through a few scenarios and this is what I think of the problem
and my solution is at the bottom.

Please let me know if this is correct.


The brief analysis is:

1.       Whenever a new stream is added

a.      a stream object having path_name, channel_name, recv_list and other
things are allocated and populated.

b.      The address of recv_list, which is a member of the stream object is
added to conn->recv_head list. conn represents a connection that is made up
of multiple streams.



2.       One of the scenarios is that when a stream is closed
RELAYD_CLOSE_STREAM, the memory allocated in 1.a is freed through a call to
ctf_trace_destroy() -> stream_delete() and stream_destroy() . However, the
entry in the conn->recv_head is not removed. This now is a dangling
pointer. The closing of stream object can happen in multiple cases and each
will cause the same dangling pointer problem. The attached .xps document
shows quite a few code paths in which this can happen, raising the
complexity.

3.       Among the use cases that access this conn->recv_head list are
set_view_ready_flag() and addition of a new stream through
relay_add_stream(). Both iterate and try to modify the list. There may be
other cases as well.



In short, there is a linked list which is made of nodes allocated in memory
regions that get freed, but the nodes in this list are not removed at that
point. Any access of this list causes the problems.




Fixes attempted so far:

https://github.com/lttng/lttng-tools/commit/cd2ef1ef1d54ced9e4d0d03b865bb7f=
c6a905f80

https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03314=
45346b15f


The above fixes of removing the node from conn->recv_head using
cds_list_del() attempts to do so from multiple places


1. relay_close_stream()


Nothing wrong in removing it here using cds_list_del()





2. connection_destroy()


This is where the problem of corruption is not getting solved. This is
because it gets called from destroy_connection()


static void destroy_connection(struct lttng_ht *relay_connections_ht,
struct relay_connection *conn)


{


                assert(relay_connections_ht);


                assert(conn);





                connection_delete(relay_connections_ht, conn);





                /* For the control socket, we try to destroy the session. *=
/


                if (conn->type =3D=3D RELAY_CONTROL && conn->session) {


                                destroy_session(conn->session,
conn->sessions_ht);


                }





                connection_destroy(conn);


}


But, destroy_session() above calls ctf_trace_destroy() which frees up the
memory allocated for the streams, thus a later attempt by
connection_destroy() to iterate over the conn->recv_head list will be a
problem as it now contains dangling pointers.



3. From my side, I thought that just calling cds_list_del() from
relay_close_stream() should fix it, however, when set_viewer_ready_flag()
is called


static void set_viewer_ready_flag(struct relay_connection *conn)


{


                struct relay_stream *stream, *tmp_stream;


                pthread_mutex_lock(&conn->session->viewer_ready_lock);


                cds_list_for_each_entry_safe(stream, tmp_stream,
&conn->recv_head,


                                                recv_list) {


                                stream->viewer_ready =3D 1;


                                cds_list_del(&stream->recv_list);


                }


                pthread_mutex_unlock(&conn->session->viewer_ready_lock);


                return;


}


It iterates over the entire conn->recv_head and removes all the entries. So
my previous solution would try to remove an entry from the list which is
already removed causing some other corruption ( the removal from the list
using cds_list_del() does not have any safety checks )



The solution that I am thinking of is below:


1.  Wherever cds_list_del(&stream->recv_list) gets called, reset the
pointers to NULL as

    stream->recv_list.next =3D stream->recv_list.prev =3D NULL;


2. Remove the entry from conn->recv_head list from only stream_delete()
after checking for above NULLs and stream->viewer_ready flag.

   The NULL set/check may not be needed as we could manage with the
viewer_ready flag alone, but in case we have missed any other scenario,
NULL would help us identity/fix it faster.




/---------------------------------------------------------------------/

The patch with the fix :

/---------------------------------------------------------------------/


diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c


index cc68410..da1b2e2 100644


--- a/src/bin/lttng-relayd/main.c


+++ b/src/bin/lttng-relayd/main.c


@@ -1153,6 +1153,8 @@ void set_viewer_ready_flag(struct relay_connection
*conn)


                        recv_list) {


                stream->viewer_ready =3D 1;


                cds_list_del(&stream->recv_list);


+               /* Reset the removed node memory, we shall check in other
places for this */


+               memset(&stream->recv_list, 0, sizeof(struct cds_list_head))=
;


        }


        pthread_mutex_unlock(&conn->session->viewer_ready_lock);


        return;








diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c


index 410fae8..7043797 100644


--- a/src/bin/lttng-relayd/stream.c


+++ b/src/bin/lttng-relayd/stream.c


@@ -144,6 +144,13 @@ void stream_delete(struct lttng_ht *ht, struct
relay_stream *stream)


        assert(!ret);





        cds_list_del(&stream->trace_list);


+/* Before we attempt to remove the stream from conn->recv_head list, need
to check if it was already removed from set_viewer_ready_flag() */


+       if(stream->viewer_ready =3D=3D 0) {


+               cds_list_del(&stream->recv_list);


+               /* Reset the removed node memory, we shall check in other
places for this */


+               memset(&stream->recv_list, 0, sizeof(struct cds_list_head))=
;


+       }


+


 }



On Tue, Jul 14, 2015 at 12:59 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> cds_list_del(&stream->recv_list) definitely needs to be called from
> relay_close_stream() else conn->recv_head will continue to have a stale
> pointer(for streams that got closed) until
> the entire connection is destroyed, and conversely,
> connection_destruction() means destroying the conn->recv_head list which
> means iterating/removing entries of streams ( some of them could be stale=
,
> if relay_close_stream() does not do cds_list_del() ) and in which case,
> cds_list_del(&stream->recv_list) needs to be called also.
>
> So removing either of them, I think, is not the good and in this case,
> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c033=
1445346b15f
> could be reverted
>
>
>  *** However *** ,
> there could also be a synchronization issue if relay_close_stream() and
> connection_destroy() can happen concurrently if these calls are not
> serialized ( stream->recv_list being accessed from two contexts ), need t=
o
> verify this before reverting
> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c033=
1445346b15f
>
>
> I also do not know the kind of issues being seen/details to prompt the
> reversal of
> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54=
ced9e4d0d03b865bb7fc6a905f80
>
>
>
> On Tue, Jul 14, 2015 at 12:17 AM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>
>> The specific change in
>> http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d5=
4ced9e4d0d03b865bb7fc6a905f80
>> that I need is for cds_list_del(&stream->recv_list); to be called.
>> Below is the patch extract.
>>
>> diff --git a/src/bin/lttng-relayd/main.c
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
>> b/src/bin/lttng-relayd/main.c
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54c=
ed9e4d0d03b865bb7fc6a905f80>
>>
>> index a93151a
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
>> ..d82a341
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54c=
ed9e4d0d03b865bb7fc6a905f80>
>> 100644 (file)
>> --- a/src/bin/lttng-relayd/main.c
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc>
>> +++ b/src/bin/lttng-relayd/main.c
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54c=
ed9e4d0d03b865bb7fc6a905f80>
>> @@ -1340,6
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd892cc#l1340>
>> +1340,18
>> <http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-re=
layd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54c=
ed9e4d0d03b865bb7fc6a905f80#l1340>
>> @@ int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
>>         session->stream_count--;
>>         assert(session->stream_count >=3D 0);
>>
>> +       /*
>>
>> +        * Remove the stream from the connection recv list since we are =
about to
>>
>> +        * flag it invalid and thus might be freed. This has to be done =
here since
>> +        * only the control thread can do actions on that list.
>> +        *
>>
>> +        * Note that this stream might NOT be in the list but we have to=
 try to
>>
>> +        * remove it here else this can race with the stream destruction=
 freeing
>>
>> +        * the object and the connection destroy doing a use after free =
when
>> +        * deleting the remaining nodes in this list.
>> +        */
>> +       cds_list_del(&stream->recv_list);
>> +
>>         /* Check if we can close it or else the data will do it. */
>>         try_close_stream(session, stream);
>>
>>
>>
>>
>>
>>
>> On Mon, Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> Do you have a specific changeset in mind when you say you applied the
>>> changes mentioned in that thread?
>>>
>>> Do you simply revert the following commit?
>>>
>>> https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0=
331445346b15f
>>>
>>> Thanks,
>>> J=C3=A9r=C3=A9mie
>>>
>>>
>>> On Sat, Jul 11, 2015 at 3:26 AM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>>
>>>> To try this fix, I also needed the changes talked about in
>>>> http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html ,
>>>> otherwise, I would see relayd coring.
>>>> Once I took them I could see that the soft hang issue was no longer
>>>> reproducible.
>>>>
>>>> Thanks for helping.
>>>>
>>>> On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <aravind.ht@gmail.com>
>>>> wrote:
>>>>
>>>>> Sure, I will try the fix and update.
>>>>>
>>>>> On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
>>>>> jeremie.galarneau@efficios.com> wrote:
>>>>>
>>>>>> Would you mind testing Mathieu's patch?
>>>>>>
>>>>>> I have rebased it on stable-2.6:
>>>>>> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>>>>>>
>>>>>> Thanks,
>>>>>> J=C3=A9r=C3=A9mie=EF=BF=BC
>>>>>>
>>>>>>
>>>>>> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
>>>>>> jeremie.galarneau@efficios.com> wrote:
>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> What do you observe when this happens? Does the session daemon
>>>>>>> become unresponsive?
>>>>>>>
>>>>>>> J=C3=A9r=C3=A9mie
>>>>>>>
>>>>>>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Request someone to kindly help with this. Blocked at this point,
>>>>>>>> unable to continue as any application crash leads to lttng not wor=
king.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Aravind.
>>>>>>>>
>>>>>>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com=
>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I have recently started trying lttng 2.6 for a few applications o=
n
>>>>>>>>> my Ubuntu 12.04 and I noticed that the health check on sessiond a=
nd
>>>>>>>>> consumerd failed soon after starting the session.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On investigating, I found that thread_manage_consumer() had exite=
d
>>>>>>>>> causing an overall health check failure.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Here are the sequence of steps that I found contributed to
>>>>>>>>> *thread_manage_consumer()* exiting.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 1.       In *thread_manage_apps() : 1558 ,
>>>>>>>>> ust_app_unregister(pollfd)* is being called. This happens when
>>>>>>>>> there is an error detected by *revents =3D
>>>>>>>>> LTTNG_POLL_GETEV(&events, i)*
>>>>>>>>>
>>>>>>>>> My initial guess here is that as one of my apps has crashed,
>>>>>>>>> producing a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated
>>>>>>>>> for *epoll()* causing *ust_app_unregister()* to be called for
>>>>>>>>> that app.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>>>>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *i=
s
>>>>>>>>> set*.*
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> (2.a) Note:* close_metadata() *also calls
>>>>>>>>> * consumer_close_metadata() *which sends
>>>>>>>>> * LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>>>>>>>> consumerd to stop it from further dealing with the concerned app.=
 Somehow
>>>>>>>>> this doesn=E2=80=99t seem to help*.*
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for
>>>>>>>>> some reason has ignored the above 2.a and gets to do request/repl=
y for that
>>>>>>>>> app by calling*ust_consumer_metadata_request():491 ->
>>>>>>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks
>>>>>>>>> for *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up=
 to
>>>>>>>>> *thread_manage_consumer():1353* at which point
>>>>>>>>> *thread_manage_consumer()* decides to exit causing health_check()
>>>>>>>>> to fail.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> So it looks like under some scenario, an application crash could
>>>>>>>>> cause the lttng some problems.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think a possible fix for this scenario, is to instead of 4, sen=
d
>>>>>>>>> an *ERROR* message back to *consumerd()* . This could be done
>>>>>>>>> from *ust_consumer_metadata_request()* call. Can someone please
>>>>>>>>> let me know if this is correct and shed more light on the issue ?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Please forgive if there are any guideline omissions for posting
>>>>>>>>> here from my part. This is my first post.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>>
>>>>>>>>> Aravind.
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> lttng-dev mailing list
>>>>>>>> lttng-dev@lists.lttng.org
>>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>>>> EfficiOS Inc.
>>>>>>> http://www.efficios.com
>>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> J=C3=A9r=C3=A9mie Galarneau
>>>>>> EfficiOS Inc.
>>>>>> http://www.efficios.com
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>

--089e0160bdaa285582051aea620e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"" style=3D"margin-left:0in">I have gone throug=
h a few scenarios and this is what I think of the problem and my solution i=
s at the bottom.</p><p class=3D"" style=3D"margin-left:0in">Please let me k=
now if this is correct.</p><p class=3D"" style=3D"margin-left:0in"><br></p>=
<p class=3D"" style=3D"margin-left:0in">The brief analysis is:</p><p class=
=3D"" style=3D"margin-left:0in">1. =C2=A0 =C2=A0 =C2=A0 Whenever a new stre=
am is added</p><p class=3D"" style=3D"margin-left:0in"><span class=3D"" sty=
le=3D"white-space:pre">	</span>a. =C2=A0 =C2=A0 =C2=A0a stream object havin=
g path_name, channel_name, recv_list and other things are allocated and pop=
ulated.</p><p class=3D"" style=3D"margin-left:0in"><span class=3D"" style=
=3D"white-space:pre">	</span>b. =C2=A0 =C2=A0 =C2=A0The address of recv_lis=
t, which is a member of the stream object is added to conn-&gt;recv_head li=
st. conn represents a connection that is made up of multiple streams.</p><p=
 class=3D"" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"marg=
in-left:0in">2. =C2=A0 =C2=A0 =C2=A0 One of the scenarios is that when a st=
ream is closed RELAYD_CLOSE_STREAM, the memory allocated in 1.a is freed th=
rough a call to ctf_trace_destroy() -&gt; stream_delete() and stream_destro=
y() . However, the entry in the conn-&gt;recv_head is not removed. This now=
 is a dangling pointer. The closing of stream object can happen in multiple=
 cases and each will cause the same dangling pointer problem. The attached =
.xps document shows quite a few code paths in which this can happen, raisin=
g the complexity.</p><p class=3D"" style=3D"margin-left:0in">3. =C2=A0 =C2=
=A0 =C2=A0 Among the use cases that access this conn-&gt;recv_head list are=
 set_view_ready_flag() and addition of a new stream through relay_add_strea=
m(). Both iterate and try to modify the list. There may be other cases as w=
ell.</p><p class=3D"" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" sty=
le=3D"margin-left:0in">In short, there is a linked list which is made of no=
des allocated in memory regions that get freed, but the nodes in this list =
are not removed at that point. Any access of this list causes the problems.=
</p><p class=3D"" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">Fixes =
attempted so far:</p><p class=3D"" style=3D"margin-left:0in"><a href=3D"htt=
ps://github.com/lttng/lttng-tools/commit/cd2ef1ef1d54ced9e4d0d03b865bb7fc6a=
905f80">https://github.com/lttng/lttng-tools/commit/cd2ef1ef1d54ced9e4d0d03=
b865bb7fc6a905f80</a></p><p class=3D"" style=3D"margin-left:0in"><a href=3D=
"https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331=
445346b15f">https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86e=
f451e4c0331445346b15f</a></p><p class=3D"" style=3D"margin-left:0in"><br></=
p><p class=3D"" style=3D"margin-left:0in">The above fixes of removing the n=
ode from conn-&gt;recv_head using cds_list_del() attempts to do so from mul=
tiple places</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D=
"" style=3D"margin-left:0in">1. relay_close_stream() =C2=A0</p><p class=3D"=
" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in"=
>Nothing wrong in removing it here using cds_list_del()</p><p class=3D"" st=
yle=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=
=A0</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=
=3D"margin-left:0in">2. connection_destroy()</p><p class=3D"" style=3D"marg=
in-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">This is where =
the problem of corruption is not getting solved. This is because it gets ca=
lled from destroy_connection()</p><p class=3D"" style=3D"margin-left:0in"><=
br></p><p class=3D"" style=3D"margin-left:0in">static void destroy_connecti=
on(struct lttng_ht *relay_connections_ht, struct relay_connection *conn)</p=
><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"mar=
gin-left:0in">{</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=
=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 assert(relay_connections_ht);</p><p class=3D"" style=3D"margi=
n-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(conn);</p><p class=3D"" st=
yle=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=
=A0</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=
=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 connection_delete(relay_connections_ht, conn);</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0=
</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"=
margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 For the control socket, we try to destroy the session. */</p><p class=3D""=
 style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (conn-&gt;type =
=3D=3D RELAY_CONTROL &amp;&amp; conn-&gt;session) {</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 destroy_session(conn-&gt;session, conn-&gt;=
sessions_ht);</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=
=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=
=3D"" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"margin-lef=
t:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 connection_destroy(conn);</p><p class=
=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:=
0in">}</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" sty=
le=3D"margin-left:0in">But, destroy_session() above calls ctf_trace_destroy=
() which frees up the memory allocated for the streams, thus a later attemp=
t by connection_destroy() to iterate over the conn-&gt;recv_head list will =
be a problem as it now contains dangling pointers.</p><p class=3D"" style=
=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"margin-left:0in">3. F=
rom my side, I thought that just calling cds_list_del() from relay_close_st=
ream() should fix it, however, when set_viewer_ready_flag() is called</p><p=
 class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin=
-left:0in">static void set_viewer_ready_flag(struct relay_connection *conn)=
</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"=
margin-left:0in">{</p><p class=3D"" style=3D"margin-left:0in"><br></p><p cl=
ass=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 struct relay_stream *stream, *tmp_stream;</p><p class=3D"=
" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_lock=
(&amp;conn-&gt;session-&gt;viewer_ready_lock);</p><p class=3D"" style=3D"ma=
rgin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_list_for_each_entry_safe(=
stream, tmp_stream, &amp;conn-&gt;recv_head,</p><p class=3D"" style=3D"marg=
in-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 recv_list) {</p><p class=3D"" style=3D"margin-left:0in"><br></p><p c=
lass=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
tream-&gt;viewer_ready =3D 1;</p><p class=3D"" style=3D"margin-left:0in"><b=
r></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cds_list_del(&amp;stream-&gt;recv_list);</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp=
;conn-&gt;session-&gt;viewer_ready_lock);</p><p class=3D"" style=3D"margin-=
left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;</p><p class=3D"" style=3D"ma=
rgin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">}</p><p clas=
s=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left=
:0in">It iterates over the entire conn-&gt;recv_head and removes all the en=
tries. So my previous solution would try to remove an entry from the list w=
hich is already removed causing some other corruption ( the removal from th=
e list using cds_list_del() does not have any safety checks )</p><p class=
=3D"" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"margin-lef=
t:0in">The solution that I am thinking of is below:</p><p class=3D"" style=
=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">1.=C2=
=A0 Wherever cds_list_del(&amp;stream-&gt;recv_list) gets called, reset the=
 pointers to NULL as</p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=
=A0 stream-&gt;recv_list.next =3D stream-&gt;recv_list.prev =3D NULL;</p><p=
 class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin=
-left:0in">2. Remove the entry from conn-&gt;recv_head list from only strea=
m_delete() after checking for above NULLs and stream-&gt;viewer_ready flag.=
</p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0The NULL set/check=
 may not be needed as we could manage with the viewer_ready flag alone, but=
 in case we have missed any other scenario, NULL would help us identity/fix=
 it faster.</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"=
" style=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"margin-left:0i=
n">/---------------------------------------------------------------------/<=
/p><p class=3D"" style=3D"margin-left:0in">The patch with the fix :</p><p c=
lass=3D"" style=3D"margin-left:0in">/--------------------------------------=
-------------------------------/</p><p class=3D"" style=3D"margin-left:0in"=
><br></p><p class=3D"" style=3D"margin-left:0in">diff --git a/src/bin/lttng=
-relayd/main.c b/src/bin/lttng-relayd/main.c</p><p class=3D"" style=3D"marg=
in-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">index cc68410.=
.da1b2e2 100644</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=
=3D"" style=3D"margin-left:0in">--- a/src/bin/lttng-relayd/main.c</p><p cla=
ss=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-lef=
t:0in">+++ b/src/bin/lttng-relayd/main.c</p><p class=3D"" style=3D"margin-l=
eft:0in"><br></p><p class=3D"" style=3D"margin-left:0in">@@ -1153,6 +1153,8=
 @@ void set_viewer_ready_flag(struct relay_connection *conn)</p><p class=
=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:=
0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 recv_list) {</p><p class=3D"" style=3D"margin-left:0in"><br><=
/p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 stream-&gt;viewer_ready =3D 1;</p><p class=3D"" st=
yle=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_list_del(&amp;stre=
am-&gt;recv_list);</p><p class=3D"" style=3D"margin-left:0in"><br></p><p cl=
ass=3D"" style=3D"margin-left:0in">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Reset the removed node memory, we shall check in other places=
 for this */</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D=
"" style=3D"margin-left:0in">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 memset(&amp;stream-&gt;recv_list, 0, sizeof(struct cds_list_head));<=
/p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"m=
argin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</p><p class=3D"" style=3D"mar=
gin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 pthread_mutex_unlock(&amp;conn-&gt;session-&gt;viewer_ready_=
lock);</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" sty=
le=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;</p><p class=3D""=
 style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">=
=C2=A0</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" sty=
le=3D"margin-left:0in">=C2=A0</p><p class=3D"" style=3D"margin-left:0in"><b=
r></p><p class=3D"" style=3D"margin-left:0in">diff --git a/src/bin/lttng-re=
layd/stream.c b/src/bin/lttng-relayd/stream.c</p><p class=3D"" style=3D"mar=
gin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">index 410fae8=
..7043797 100644</p><p class=3D"" style=3D"margin-left:0in"><br></p><p clas=
s=3D"" style=3D"margin-left:0in">--- a/src/bin/lttng-relayd/stream.c</p><p =
class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-=
left:0in">+++ b/src/bin/lttng-relayd/stream.c</p><p class=3D"" style=3D"mar=
gin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">@@ -144,6 +14=
4,13 @@ void stream_delete(struct lttng_ht *ht, struct relay_stream *stream=
)</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D=
"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(!ret);</p><p class=3D"=
" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in"=
>=C2=A0</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" st=
yle=3D"margin-left:0in">=C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_list_del(&amp;strea=
m-&gt;trace_list);</p><p class=3D"" style=3D"margin-left:0in"><br></p><p cl=
ass=3D"" style=3D"margin-left:0in">+/* Before we attempt to remove the stre=
am from conn-&gt;recv_head list, need to check if it was already removed fr=
om set_viewer_ready_flag() */</p><p class=3D"" style=3D"margin-left:0in"><b=
r></p><p class=3D"" style=3D"margin-left:0in">+ =C2=A0 =C2=A0 =C2=A0 if(str=
eam-&gt;viewer_ready =3D=3D 0) {</p><p class=3D"" style=3D"margin-left:0in"=
><br></p><p class=3D"" style=3D"margin-left:0in">+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cds_list_del(&amp;stream-&gt;recv_list);</p><p cla=
ss=3D"" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-lef=
t:0in">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reset the remo=
ved node memory, we shall check in other places for this */</p><p class=3D"=
" style=3D"margin-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in"=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;stream-&gt;=
recv_list, 0, sizeof(struct cds_list_head));</p><p class=3D"" style=3D"marg=
in-left:0in"><br></p><p class=3D"" style=3D"margin-left:0in">+ =C2=A0 =C2=
=A0 =C2=A0 }</p><p class=3D"" style=3D"margin-left:0in"><br></p><p class=3D=
"" style=3D"margin-left:0in">+</p><p class=3D"" style=3D"margin-left:0in"><=
br></p><p class=3D"" style=3D"margin-left:0in">=C2=A0}</p><p class=3D"" sty=
le=3D"margin-left:0in"><br></p></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Tue, Jul 14, 2015 at 12:59 AM, Aravind HT <span dir=
=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"ltr"><div><span style=3D"color:rgb(0,134,179);font-family:Consola=
s,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-hei=
ght:16.7999992370605px;white-space:pre-wrap;background-color:rgb(255,236,23=
6)">cds_list_del</span><span style=3D"color:rgb(51,51,51);font-family:Conso=
las,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-h=
eight:16.7999992370605px;white-space:pre-wrap;background-color:rgb(255,236,=
236)">(&amp;stream-&gt;recv_list) definitely needs to be called from relay_=
close_stream() else </span><span style=3D"color:rgb(51,51,51);font-family:C=
onsolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;li=
ne-height:16.7999992370605px;white-space:pre-wrap;background-color:rgb(255,=
236,236)">conn-&gt;recv_head will continue to have a stale pointer(for stre=
ams that got closed) until=C2=A0</span></div><div><span style=3D"color:rgb(=
51,51,51);font-family:Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,mono=
space;font-size:12px;line-height:16.7999992370605px;white-space:pre-wrap;ba=
ckground-color:rgb(255,236,236)">the entire connection is destroyed, and co=
nversely, connection_destruction() means destroying the conn-&gt;recv_head =
list which means iterating/removing entries of streams ( some of them could=
 be stale,</span></div><div><span style=3D"color:rgb(51,51,51);font-family:=
Consolas,&#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;l=
ine-height:16.7999992370605px;white-space:pre-wrap;background-color:rgb(255=
,236,236)">if relay_close_stream() does not do cds_list_del() ) and in whic=
h case, </span><span style=3D"color:rgb(0,134,179);font-family:Consolas,&#3=
9;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-height:1=
6.7999992370605px;white-space:pre-wrap;background-color:rgb(255,236,236)">c=
ds_list_del</span><span style=3D"color:rgb(51,51,51);font-family:Consolas,&=
#39;Liberation Mono&#39;,Menlo,Courier,monospace;font-size:12px;line-height=
:16.7999992370605px;white-space:pre-wrap;background-color:rgb(255,236,236)"=
>(&amp;stream-&gt;recv_list) needs to be called also.</span></div><div><spa=
n style=3D"color:rgb(51,51,51);font-family:Consolas,&#39;Liberation Mono&#3=
9;,Menlo,Courier,monospace;font-size:12px;line-height:16.7999992370605px;wh=
ite-space:pre-wrap;background-color:rgb(255,236,236)"><br></span></div><div=
><font color=3D"#333333" face=3D"Consolas, Liberation Mono, Menlo, Courier,=
 monospace"><span style=3D"font-size:12px;line-height:16.7999992370605px;wh=
ite-space:pre-wrap;background-color:rgb(255,236,236)">So removing either of=
 them, I think, is not the good and in this case, </span></font><a href=3D"=
https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03314=
45346b15f" target=3D"_blank">https://github.com/lttng/lttng-tools/commit/1d=
c0526df43f2b5f86ef451e4c0331445346b15f</a> could be reverted</div><div><br>=
</div><div><br></div><div>=C2=A0*** However *** ,=C2=A0</div><div>there cou=
ld also be a synchronization issue if relay_close_stream() and connection_d=
estroy() can happen concurrently if these calls are not serialized ( stream=
-&gt;recv_list being accessed from two contexts ), need to verify this befo=
re reverting <a href=3D"https://github.com/lttng/lttng-tools/commit/1dc0526=
df43f2b5f86ef451e4c0331445346b15f" target=3D"_blank">https://github.com/ltt=
ng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f</a> =C2=A0</=
div><div><br></div><div>I also do not know the kind of issues being seen/de=
tails to prompt the reversal of=C2=A0<a href=3D"http://git.lttng.org/?p=3Dl=
ttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80"=
 target=3D"_blank">http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff=
;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80</a></div><div><br></div><div>=
<br></div></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Tue, Jul 14, 2015 at 12:17 AM, Ar=
avind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" targ=
et=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"ltr">The specific change in=C2=A0<a href=3D"htt=
p://git.lttng.org/?p=3Dlttng-tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e=
4d0d03b865bb7fc6a905f80" target=3D"_blank">http://git.lttng.org/?p=3Dlttng-=
tools.git;a=3Dcommitdiff;h=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80</a><d=
iv>that I need is for=C2=A0<span style=3D"color:rgb(0,0,0);font-family:Cons=
olas,&#39;Bitstream Vera Sans Mono&#39;,monospace;font-size:13px;line-heigh=
t:18.2000007629395px;white-space:pre-wrap;background-color:rgb(221,255,221)=
">cds_list_del(&amp;stream-&gt;recv_list); to be called.=C2=A0</span></div>=
<div><span style=3D"color:rgb(0,0,0);font-family:Consolas,&#39;Bitstream Ve=
ra Sans Mono&#39;,monospace;font-size:13px;line-height:18.2000007629395px;w=
hite-space:pre-wrap;background-color:rgb(221,255,221)">Below is the patch e=
xtract.</span></div><div><span style=3D"font-size:13px;color:rgb(0,0,0);fon=
t-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;line-height:=
18.2000007629395px;white-space:pre-wrap;background-color:rgb(234,242,245)">=
<br></span></div><div><span style=3D"font-size:13px;color:rgb(0,0,0);font-f=
amily:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;line-height:18.=
2000007629395px;white-space:pre-wrap;background-color:rgb(234,242,245)">dif=
f --git </span><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=3Dblo=
b;f=3Dsrc/bin/lttng-relayd/main.c;h=3Da93151ac47f560875f07c9cbf113225f9dd89=
2cc" style=3D"font-size:13px;margin:0px;padding:0px;border:0px;outline:none=
;vertical-align:baseline;color:rgb(65,131,196);text-decoration:none;font-fa=
mily:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;line-height:18.2=
000007629395px;white-space:pre-wrap;background:transparent" target=3D"_blan=
k">a/src/bin/lttng-relayd/main.c</a><span style=3D"font-size:13px;color:rgb=
(0,0,0);font-family:Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;l=
ine-height:18.2000007629395px;white-space:pre-wrap;background-color:rgb(234=
,242,245)"> </span><a href=3D"http://git.lttng.org/?p=3Dlttng-tools.git;a=
=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Dd82a3412d7b8578be8f5b39abf0a9fd=
949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905f80" style=3D"font-size=
:13px;margin:0px;padding:0px;border:0px;outline:none;vertical-align:baselin=
e;color:rgb(65,131,196);text-decoration:none;font-family:Consolas,&#39;Bits=
tream Vera Sans Mono&#39;,monospace;line-height:18.2000007629395px;white-sp=
ace:pre-wrap;background:transparent" target=3D"_blank">b/src/bin/lttng-rela=
yd/main.c</a></div><div><br></div><div><div style=3D"margin:0px;padding:0px=
;border:0px;outline:0px;font-size:13px;vertical-align:baseline;font-family:=
Consolas,&#39;Bitstream Vera Sans Mono&#39;,monospace;width:1480.5625px;whi=
te-space:pre-wrap;color:rgb(0,0,0);line-height:18.2000007629395px;backgroun=
d:rgb(248,248,248)">index <a href=3D"http://git.lttng.org/?p=3Dlttng-tools.=
git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Da93151ac47f560875f07c9cbf1=
13225f9dd892cc" style=3D"margin:0px;padding:0px;border:0px;outline:none;ver=
tical-align:baseline;color:rgb(65,131,196);text-decoration:none;background:=
transparent" target=3D"_blank">a93151a</a>..<a href=3D"http://git.lttng.org=
/?p=3Dlttng-tools.git;a=3Dblob;f=3Dsrc/bin/lttng-relayd/main.c;h=3Dd82a3412=
d7b8578be8f5b39abf0a9fd949ff07bc;hb=3Dcd2ef1ef1d54ced9e4d0d03b865bb7fc6a905=
f80" style=3D"margin:0px;padding:0px;border:0px;outline:none;vertical-align=
:baseline;color:rgb(65,131,196);text-decoration:none;background:transparent=
" target=3D"_blank">d82a341</a> 100644<span style=3D"margin:0px;padding:0px=
;border:0px;outline:0px;vertical-align:baseline;background:transparent"> (f=
ile)</span><br>
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
<div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon,=
 Jul 13, 2015 at 9:04 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">jeremi=
e.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr">Do you have a specific changeset in mind when you sa=
y you applied the changes mentioned in that thread?<div><br></div><div>Do y=
ou simply revert the following commit?</div><div><a href=3D"https://github.=
com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f" targ=
et=3D"_blank">https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f8=
6ef451e4c0331445346b15f</a></div><div><br></div><div>Thanks,</div><div>J=C3=
=A9r=C3=A9mie<div><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Sat, Jul 11, 2015 at 3:26 AM, Aravind HT <span dir=3D"ltr">&lt=
;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr">To try this=
 fix, I also needed the changes talked about in=C2=A0<a href=3D"http://list=
s.lttng.org/pipermail/lttng-dev/2015-July/024689.html" target=3D"_blank">ht=
tp://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html</a> , otherw=
ise, I would see relayd coring.<div>Once I took them I could see that the s=
oft hang issue was no longer reproducible.=C2=A0</div><div><br></div><div>T=
hanks for helping.</div></div><div><div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <span dir=
=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">arav=
ind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:=
rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"=
>Sure, I will try the fix and update.</div><div><div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 10:12 PM, J=C3=
=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.gal=
arneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex"><div dir=3D"ltr">Would you mind testin=
g Mathieu&#39;s patch?<div><br></div><div>I have rebased it on stable-2.6:<=
/div><div><div>git clone <a href=3D"https://github.com/jgalar/lttng-tools.g=
it" target=3D"_blank">https://github.com/jgalar/lttng-tools.git</a> -b hang=
-fix<br></div></div><div><br></div><div><div>Thanks,</div><div>J=C3=A9r=C3=
=A9mie=EF=BF=BC</div></div><div><br></div></div><div><div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 11:23 AM, J=
=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.=
galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div>=
<div>What do you observe when this happens? Does the session daemon become =
unresponsive?</div><div><br></div><div>J=C3=A9r=C3=A9mie</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div>On Wed, May 27=
, 2015 at 6:19 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravi=
nd.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrot=
e:<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-=
left-style:solid;padding-left:1ex"><div><div><div dir=3D"ltr">Request someo=
ne to kindly help with this. Blocked at this point, unable to continue as a=
ny application crash leads to lttng not working.<div><br></div><div>Thanks,=
</div><div>Aravind.</div></div><div><div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Thu, May 21, 2015 at 12:18 AM, Aravind HT <span =
dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">a=
ravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div dir=3D"l=
tr"><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Hi,</p><p=
 class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I have recently st=
arted trying lttng 2.6 for a few applications on my Ubuntu 12.04 and I noti=
ced that the health check on sessiond and consumerd failed soon after start=
ing the session.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907=
349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px=
">On investigating, I found that thread_manage_consumer() had exited causin=
g an overall health check failure.</p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:=
12.8000001907349px">Here are the sequence of steps that I found contributed=
 to=C2=A0<b>thread_manage_consumer()</b>=C2=A0exiting.</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px"></p><p class=3D"MsoNormal" sty=
le=3D"font-size:12.8000001907349px"><br></p><p style=3D"font-size:12.800000=
1907349px">1.<span style=3D"font-stretch:normal;font-size:7pt;font-family:&=
#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>=
In=C2=A0<b>thread_manage_apps() : 1558 , ust_app_unregister(pollfd)</b>=C2=
=A0is being called. This happens when there is an error detected by=C2=A0<b=
>revents =3D LTTNG_POLL_GETEV(&amp;events, i)</b></p><p style=3D"font-size:=
12.8000001907349px">My initial guess here is that as one of my apps has cra=
shed, producing a=C2=A0<b>LPOLLERR | LPOLLHUP | LPOLLRDHUP=C2=A0</b>to be g=
enerated for=C2=A0<b>epoll()</b>=C2=A0causing=C2=A0<b>ust_app_unregister()<=
/b>=C2=A0to be called for that app.</p><p style=3D"font-size:12.80000019073=
49px">=C2=A0</p><p style=3D"font-size:12.8000001907349px">2.<span style=3D"=
font-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>ust_app_unregis=
ter():3154 , close_metadata(registry, ua_sess-&gt;consumer)=C2=A0=C2=A0</b>=
in which<b>=C2=A0registry-&gt;metadata_closed =3D 1=C2=A0</b>is set<b>.</b>=
</p><p style=3D"font-size:12.8000001907349px;text-indent:0.5in">=C2=A0</p><=
p style=3D"font-size:12.8000001907349px;text-indent:0.5in">(2.a) Note:<b>=
=C2=A0close_metadata()=C2=A0</b>also calls<b>=C2=A0consumer_close_metadata(=
)=C2=A0</b>which sends<b>=C2=A0LTTNG_CONSUMER_CLOSE_METADATA=C2=A0</b>and<b=
>=C2=A0metadata_key=C2=A0</b>to the consumerd to stop it from further deali=
ng with the concerned app. Somehow this doesn=E2=80=99t seem to help<b>.</b=
></p><p style=3D"font-size:12.8000001907349px"><b>=C2=A0</b></p><p style=3D=
"font-size:12.8000001907349px">3.<span style=3D"font-stretch:normal;font-si=
ze:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0</span>Next, I see that the=C2=A0<b>thread_manage_consumer()=
:1353</b>=C2=A0for some reason has ignored the above 2.a and gets to do req=
uest/reply for that app by calling<b>ust_consumer_metadata_request():491 -&=
gt; ust_app_push_metadat(ust_reg, socket,1)=C2=A0</b>which at line 460 chec=
ks for=C2=A0<b>registry-&gt;metadata_closed</b>=C2=A0and returns an=C2=A0<b=
>=E2=80=93EPIPE</b></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001=
907349px">=C2=A0</p><p style=3D"font-size:12.8000001907349px">4.<span style=
=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;=
">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>This=C2=A0<b>=E2=80=93EP=
IPE</b>=C2=A0error cascades all the way back up to=C2=A0<b>thread_manage_co=
nsumer():1353</b>=C2=A0at which point=C2=A0<b>thread_manage_consumer()</b>=
=C2=A0decides to exit causing health_check() to fail.</p><p style=3D"font-s=
ize:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size=
:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12=
.8000001907349px">So it looks like under some scenario, an application cras=
h could cause the lttng some problems.</p><p class=3D"MsoNormal" style=3D"f=
ont-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font=
-size:12.8000001907349px">I think a possible fix for this scenario, is to i=
nstead of 4, send an=C2=A0<b>ERROR</b>=C2=A0message back to=C2=A0<b>consume=
rd()</b>=C2=A0. This could be done from=C2=A0<b>ust_consumer_metadata_reque=
st()</b>=C2=A0call. Can someone please let me know if this is correct and s=
hed more light on the issue ?</p><p class=3D"MsoNormal" style=3D"font-size:=
12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.=
8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.800=
0001907349px">Please forgive if there are any guideline omissions for posti=
ng here from my part. This is my first post.</p><p class=3D"MsoNormal" styl=
e=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"=
font-size:12.8000001907349px">Regards,</p><p class=3D"MsoNormal" style=3D"f=
ont-size:12.8000001907349px">Aravind.</p></div>
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
</div></div></blockquote></div><br></div>

--089e0160bdaa285582051aea620e--


--===============0251703550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0251703550==--
