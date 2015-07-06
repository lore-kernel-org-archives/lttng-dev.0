From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Fix: metadata push -EPIPE
 should be recoverable
Date: Mon, 6 Jul 2015 18:42:13 +0000 (UTC)
Message-ID: <991200281.1051.1436208133391.JavaMail.zimbra__26975.8678660311$1436208202$gmane$org@efficios.com>
References: <1436199666-10305-1-git-send-email-mathieu.desnoyers@efficios.com>
 <CACd+_b5JdeMZ58PPLAK=8+4BWqy4-XPZ3DenbJ9CqcRk-XWOLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1356135586=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZCBLV-0000kB-21
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 14:42:27 -0400
In-Reply-To: <CACd+_b5JdeMZ58PPLAK=8+4BWqy4-XPZ3DenbJ9CqcRk-XWOLg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "HT, Aravind" <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1356135586==
Content-Type: multipart/alternative;
	boundary="----=_Part_1050_1385982139.1436208133389"

------=_Part_1050_1385982139.1436208133389
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

We should not have to send any error back to the consumer because the 
app disappearing will eventually close all file descriptors related to the 
communication and notification pipes (sessiond vs apps), as well as all 
stream file descriptors (consumerd vs apps). So the consumerd will 
eventually be notified that the application disappeared, and will therefore 
close the associated streams (in per-pid buffers) in due time. 

Thanks, 

Mathieu 

----- On Jul 6, 2015, at 12:42 PM, HT, Aravind <aravind.ht@gmail.com> wrote: 

> In case of -EPIPE, im thinking if we can send LTTNG_ERR_UND or some other error
> back to the consumer for it to do any relevant clean up.

> On Mon, Jul 6, 2015 at 9:51 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> This return value can be caused by application terminating concurrently
>> (when using per-PID buffers), so it should not make the consumer
>> management thread exit.

>> CC: Aravind HT < aravind.ht@gmail.com >
>> Signed-off-by: Mathieu Desnoyers < mathieu.desnoyers@efficios.com >
>> ---
>> src/bin/lttng-sessiond/ust-app.c | 13 ++++++++++---
>> src/bin/lttng-sessiond/ust-consumer.c | 7 +++++--
>> 2 files changed, 15 insertions(+), 5 deletions(-)

>> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
>> index c30792c..6f032da 100644
>> --- a/src/bin/lttng-sessiond/ust-app.c
>> +++ b/src/bin/lttng-sessiond/ust-app.c
>> @@ -431,6 +431,9 @@ void delete_ust_app_channel(int sock, struct ust_app_channel
>> *ua_chan,
>> * Must be called with the registry lock held.
>> *
>> * On success, return the len of metadata pushed or else a negative value.
>> + * Returning a -EPIPE return value means we could not send the metadata,
>> + * but it can be caused by recoverable errors (e.g. the application has
>> + * terminated concurrently).
>> */
>> ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
>> struct consumer_socket *socket, int send_zero_data)
>> @@ -454,9 +457,10 @@ ssize_t ust_app_push_metadata(struct ust_registry_session
>> *registry,
>> /*
>> * On a push metadata error either the consumer is dead or the
>> * metadata channel has been destroyed because its endpoint
>> - * might have died (e.g: relayd). If so, the metadata closed
>> - * flag is set to 1 so we deny pushing metadata again which is
>> - * not valid anymore on the consumer side.
>> + * might have died (e.g: relayd), or because the application has
>> + * exited. If so, the metadata closed flag is set to 1 so we
>> + * deny pushing metadata again which is not valid anymore on the
>> + * consumer side.
>> */
>> if (registry->metadata_closed) {
>> return -EPIPE;
>> @@ -547,6 +551,9 @@ error_push:
>> * of socket throughout this function.
>> *
>> * Return 0 on success else a negative error.
>> + * Returning a -EPIPE return value means we could not send the metadata,
>> + * but it can be caused by recoverable errors (e.g. the application has
>> + * terminated concurrently).
>> */
>> static int push_metadata(struct ust_registry_session *registry,
>> struct consumer_output *consumer)
>> diff --git a/src/bin/lttng-sessiond/ust-consumer.c
>> b/src/bin/lttng-sessiond/ust-consumer.c
>> index 78e50df..ad076e3 100644
>> --- a/src/bin/lttng-sessiond/ust-consumer.c
>> +++ b/src/bin/lttng-sessiond/ust-consumer.c
>> @@ -511,12 +511,15 @@ int ust_consumer_metadata_request(struct consumer_socket
>> *socket)
>> pthread_mutex_lock(&ust_reg->lock);
>> ret_push = ust_app_push_metadata(ust_reg, socket, 1);
>> pthread_mutex_unlock(&ust_reg->lock);
>> - if (ret_push < 0) {
>> + if (ret_push == -EPIPE) {
>> + DBG("Application or relay closed while pushing metadata");
>> + } else if (ret_push < 0) {
>> ERR("Pushing metadata");
>> ret = -1;
>> goto end;
>> + } else {
>> + DBG("UST Consumer metadata pushed successfully");
>> }
>> - DBG("UST Consumer metadata pushed successfully");
>> ret = 0;

>> end:
>> --
>> 2.1.4

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_1050_1385982139.1436208133389
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>We should not have to send any error back t=
o the consumer because the</div><div>app disappearing will eventually close=
 all file descriptors related to the</div><div>communication and notificati=
on pipes (sessiond vs apps), as well as all</div><div>stream file descripto=
rs (consumerd vs apps). So the consumerd will</div><div>eventually be notif=
ied that the application disappeared, and will therefore</div><div>close th=
e associated streams (in per-pid buffers) in due time.<br data-mce-bogus=3D=
"1"></div><div><br></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><span id=3D"zwchr" data-marker=3D"__DIVIDE=
R__">----- On Jul 6, 2015, at 12:42 PM, HT, Aravind &lt;aravind.ht@gmail.co=
m&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT__"><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">In case of -EP=
IPE, im thinking if we can send&nbsp;<span style=3D"color:rgb(0,0,0);white-=
space:pre-wrap">LTTNG_ERR_UND or some other error back to the consumer for =
it to do any relevant clean up.</span></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 9:51 PM, Mathieu Desnoyer=
s <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" t=
arget=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">This return value can be caused by application=
 terminating concurrently<br>
(when using per-PID buffers), so it should not make the consumer<br>
management thread exit.<br>
<br>
CC: Aravind HT &lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank=
">aravind.ht@gmail.com</a>&gt;<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
&nbsp;src/bin/lttng-sessiond/ust-app.c&nbsp; &nbsp; &nbsp; | 13 ++++++++++-=
--<br>
&nbsp;src/bin/lttng-sessiond/ust-consumer.c |&nbsp; 7 +++++--<br>
&nbsp;2 files changed, 15 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-=
app.c<br>
index c30792c..6f032da 100644<br>
--- a/src/bin/lttng-sessiond/ust-app.c<br>
+++ b/src/bin/lttng-sessiond/ust-app.c<br>
@@ -431,6 +431,9 @@ void delete_ust_app_channel(int sock, struct ust_app_ch=
annel *ua_chan,<br>
&nbsp; * Must be called with the registry lock held.<br>
&nbsp; *<br>
&nbsp; * On success, return the len of metadata pushed or else a negative v=
alue.<br>
+ * Returning a -EPIPE return value means we could not send the metadata,<b=
r>
+ * but it can be caused by recoverable errors (e.g. the application has<br=
>
+ * terminated concurrently).<br>
&nbsp; */<br>
&nbsp;ssize_t ust_app_push_metadata(struct ust_registry_session *registry,<=
br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct consumer_soc=
ket *socket, int send_zero_data)<br>
@@ -454,9 +457,10 @@ ssize_t ust_app_push_metadata(struct ust_registry_sess=
ion *registry,<br>
&nbsp; &nbsp; &nbsp; &nbsp; /*<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* On a push metadata error either the con=
sumer is dead or the<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* metadata channel has been destroyed bec=
ause its endpoint<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * might have died (e.g: relayd). If so, the me=
tadata closed<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * flag is set to 1 so we deny pushing metadata=
 again which is<br>
-&nbsp; &nbsp; &nbsp; &nbsp; * not valid anymore on the consumer side.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * might have died (e.g: relayd), or because th=
e application has<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * exited. If so, the metadata closed flag is s=
et to 1 so we<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * deny pushing metadata again which is not val=
id anymore on the<br>
+&nbsp; &nbsp; &nbsp; &nbsp; * consumer side.<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (registry-&gt;metadata_closed) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EPIPE;<br>
@@ -547,6 +551,9 @@ error_push:<br>
&nbsp; * of socket throughout this function.<br>
&nbsp; *<br>
&nbsp; * Return 0 on success else a negative error.<br>
+ * Returning a -EPIPE return value means we could not send the metadata,<b=
r>
+ * but it can be caused by recoverable errors (e.g. the application has<br=
>
+ * terminated concurrently).<br>
&nbsp; */<br>
&nbsp;static int push_metadata(struct ust_registry_session *registry,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct consumer_out=
put *consumer)<br>
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond=
/ust-consumer.c<br>
index 78e50df..ad076e3 100644<br>
--- a/src/bin/lttng-sessiond/ust-consumer.c<br>
+++ b/src/bin/lttng-sessiond/ust-consumer.c<br>
@@ -511,12 +511,15 @@ int ust_consumer_metadata_request(struct consumer_soc=
ket *socket)<br>
&nbsp; &nbsp; &nbsp; &nbsp; pthread_mutex_lock(&amp;ust_reg-&gt;lock);<br>
&nbsp; &nbsp; &nbsp; &nbsp; ret_push =3D ust_app_push_metadata(ust_reg, soc=
ket, 1);<br>
&nbsp; &nbsp; &nbsp; &nbsp; pthread_mutex_unlock(&amp;ust_reg-&gt;lock);<br=
>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret_push &lt; 0) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (ret_push =3D=3D -EPIPE) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DBG("Application or=
 relay closed while pushing metadata");<br>
+&nbsp; &nbsp; &nbsp; &nbsp;} else if (ret_push &lt; 0) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ERR("Pushing metada=
ta");<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D -1;<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto end;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DBG("UST Consumer m=
etadata pushed successfully");<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
-&nbsp; &nbsp; &nbsp; &nbsp;DBG("UST Consumer metadata pushed successfully"=
);<br>
&nbsp; &nbsp; &nbsp; &nbsp; ret =3D 0;<br>
<br>
&nbsp;end:<br>
<span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"co=
lor: #888888;" color=3D"#888888">--<br>
2.1.4<br>
<br>
</span></span></blockquote></div></div><br></blockquote></div><br><div data=
-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS In=
c.<br>http://www.efficios.com</div></div></body></html>
------=_Part_1050_1385982139.1436208133389--


--===============1356135586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1356135586==--
