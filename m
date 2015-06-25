From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Save/load: add support for
	shared memory path
Date: Thu, 25 Jun 2015 13:09:55 -0400
Message-ID: <CA+jJMxv1SUpK_JTfdjsrqZ9s3GzuvbK3u5VmdPZnGCshU90ZTQ__38780.9761836708$1435252297$gmane$org@mail.gmail.com>
References: <1429306001-12872-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0875720718=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Z8Af2-0004S8-T7
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 13:10:10 -0400
Received: by pdcu2 with SMTP id u2so57245055pdc.3
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 10:09:55 -0700 (PDT)
In-Reply-To: <1429306001-12872-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0875720718==
Content-Type: multipart/alternative; boundary=001a11c1dc9440086405195ab12b

--001a11c1dc9440086405195ab12b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged with a memory leak fix, read on.

Thanks!
J=C3=A9r=C3=A9mie

On Fri, Apr 17, 2015 at 5:26 PM, Jonathan Rajotte <
jonathan.rajotte-julien@efficios.com> wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/bin/lttng-sessiond/save.c          | 10 ++++++++++
>  src/common/config/config-session-abi.h |  1 +
>  src/common/config/config.c             | 19 +++++++++++++++++++
>  src/common/config/session.xsd          |  1 +
>  4 files changed, 31 insertions(+)
>
> diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.=
c
> index 0c6894b..d6316ef 100644
> --- a/src/bin/lttng-sessiond/save.c
> +++ b/src/bin/lttng-sessiond/save.c
> @@ -1663,6 +1663,16 @@ int save_session(struct ltt_session *session,
>                 goto end;
>         }
>
> +       if(session->shm_path[0] !=3D '\0') {
> +               ret =3D config_writer_write_element_string(writer,
> +                               config_element_shared_memory_path,
> +                               session->shm_path);
> +               if (ret) {
> +                       ret =3D LTTNG_ERR_SAVE_IO_FAIL;
> +                       goto end;
> +               }
> +       }
> +
>         ret =3D save_domains(writer, session);
>         if (ret) {
>                 goto end;
> diff --git a/src/common/config/config-session-abi.h
> b/src/common/config/config-session-abi.h
> index 8cbff25..8ac5cb0 100644
> --- a/src/common/config/config-session-abi.h
> +++ b/src/common/config/config-session-abi.h
> @@ -67,6 +67,7 @@ const char * const config_element_data_uri;
>  const char * const config_element_max_size;
>  const char * const config_element_pid;
>  const char * const config_element_pids;
> +const char * const config_element_shared_memory_path;
>
>  const char * const config_domain_type_kernel;
>  const char * const config_domain_type_ust;
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index d84e38b..bc4f0c0 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -117,6 +117,7 @@ const char * const config_element_data_uri =3D
> "data_uri";
>  const char * const config_element_max_size =3D "max_size";
>  const char * const config_element_pid =3D "pid";
>  const char * const config_element_pids =3D "pids";
> +const char * const config_element_shared_memory_path =3D
> "shared_memory_path";
>
>  const char * const config_domain_type_kernel =3D "KERNEL";
>  const char * const config_domain_type_ust =3D "UST";
> @@ -2172,6 +2173,7 @@ int process_session_node(xmlNodePtr session_node,
> const char *session_name,
>         int ret, started =3D -1, snapshot_mode =3D -1;
>         uint64_t live_timer_interval =3D UINT64_MAX;
>         char *name =3D NULL;
> +       char *shm_path =3D NULL;
>         xmlNodePtr domains_node =3D NULL;
>         xmlNodePtr output_node =3D NULL;
>         xmlNodePtr node;
> @@ -2216,6 +2218,16 @@ int process_session_node(xmlNodePtr session_node,
> const char *session_name,
>                         config_element_output)) {
>                         /* output */
>                         output_node =3D node;
> +               } else if (!shm_path && !strcmp((const char *) node->name=
,
> +
>  config_element_shared_memory_path)) {
> +                       /* shared memory path */
> +                       xmlChar *node_content =3D xmlNodeGetContent(node)=
;
>

As per the libxml docs[1]:

xmlNodeGetContent():
Returns: a new #xmlChar * or NULL if no content is available. It's up to
the caller to free the memory with xmlFree().

I have added an xmlFree() call to the teardown.

[1] http://xmlsoft.org/html/libxml-tree.html#xmlNodeGetContent

+                       if (!node_content) {
> +                               ret =3D -LTTNG_ERR_NOMEM;
> +                               goto error;
> +                       }
> +
> +                       shm_path =3D (char *) node_content;
>                 } else {
>                         /* attributes, snapshot_mode or
> live_timer_interval */
>                         xmlNodePtr attributes_child =3D
> @@ -2356,6 +2368,13 @@ domain_init_error:
>                 goto error;
>         }
>
> +       if (shm_path) {
> +               ret =3D lttng_set_session_shm_path(name, shm_path);
> +               if (ret) {
> +                       goto error;
> +               }
> +       }
> +
>         for (node =3D xmlFirstElementChild(domains_node); node;
>                 node =3D xmlNextElementSibling(node)) {
>                 ret =3D process_domain_node(node, name);
> diff --git a/src/common/config/session.xsd b/src/common/config/session.xs=
d
> index 6d74e85..0a7458d 100644
> --- a/src/common/config/session.xsd
> +++ b/src/common/config/session.xsd
> @@ -279,6 +279,7 @@ elementFormDefault=3D"qualified" version=3D"2.5">
>  <xs:complexType name=3D"session_type">
>         <xs:all>
>                 <xs:element name=3D"name" type=3D"name_type"/>
> +               <xs:element name=3D"shared_memory_path" type=3D"xs:string=
"
> minOccurs=3D"0"/>
>                 <xs:element name=3D"domains" type=3D"domain_list_type"
> minOccurs=3D"0"/>
>                 <xs:element name=3D"started" type=3D"xs:boolean" default=
=3D"0"
> minOccurs=3D"0"/>
>                 <xs:element name=3D"attributes"
> type=3D"session_attributes_type" minOccurs=3D"0"/>
> --
> 2.1.4
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c1dc9440086405195ab12b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged with a memory leak fix, read on.<div><br></div><div=
>Thanks!</div><div>J=C3=A9r=C3=A9mie</div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Fri, Apr 17, 2015 at 5:26 PM, Jonathan Rajotte =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.co=
m" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style=
:solid;padding-left:1ex">Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mai=
lto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajott=
e-julien@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/bin/lttng-sessiond/save.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 =
++++++++++<br>
=C2=A0src/common/config/config-session-abi.h |=C2=A0 1 +<br>
=C2=A0src/common/config/config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 19 +++++++++++++++++++<br>
=C2=A0src/common/config/session.xsd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
=C2=A04 files changed, 31 insertions(+)<br>
<br>
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c<=
br>
index 0c6894b..d6316ef 100644<br>
--- a/src/bin/lttng-sessiond/save.c<br>
+++ b/src/bin/lttng-sessiond/save.c<br>
@@ -1663,6 +1663,16 @@ int save_session(struct ltt_session *session,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if(session-&gt;shm_path[0] !=3D &#39;\0&#39;) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D config_writ=
er_write_element_string(writer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_element_shared_memory_path,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;shm_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D LTTNG_ERR_SAVE_IO_FAIL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D save_domains(writer, session);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
diff --git a/src/common/config/config-session-abi.h b/src/common/config/con=
fig-session-abi.h<br>
index 8cbff25..8ac5cb0 100644<br>
--- a/src/common/config/config-session-abi.h<br>
+++ b/src/common/config/config-session-abi.h<br>
@@ -67,6 +67,7 @@ const char * const config_element_data_uri;<br>
=C2=A0const char * const config_element_max_size;<br>
=C2=A0const char * const config_element_pid;<br>
=C2=A0const char * const config_element_pids;<br>
+const char * const config_element_shared_memory_path;<br>
<br>
=C2=A0const char * const config_domain_type_kernel;<br>
=C2=A0const char * const config_domain_type_ust;<br>
diff --git a/src/common/config/config.c b/src/common/config/config.c<br>
index d84e38b..bc4f0c0 100644<br>
--- a/src/common/config/config.c<br>
+++ b/src/common/config/config.c<br>
@@ -117,6 +117,7 @@ const char * const config_element_data_uri =3D &quot;da=
ta_uri&quot;;<br>
=C2=A0const char * const config_element_max_size =3D &quot;max_size&quot;;<=
br>
=C2=A0const char * const config_element_pid =3D &quot;pid&quot;;<br>
=C2=A0const char * const config_element_pids =3D &quot;pids&quot;;<br>
+const char * const config_element_shared_memory_path =3D &quot;shared_memo=
ry_path&quot;;<br>
<br>
=C2=A0const char * const config_domain_type_kernel =3D &quot;KERNEL&quot;;<=
br>
=C2=A0const char * const config_domain_type_ust =3D &quot;UST&quot;;<br>
@@ -2172,6 +2173,7 @@ int process_session_node(xmlNodePtr session_node, con=
st char *session_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret, started =3D -1, snapshot_mode =3D -1;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t live_timer_interval =3D UINT64_MAX;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *name =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *shm_path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xmlNodePtr domains_node =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xmlNodePtr output_node =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xmlNodePtr node;<br>
@@ -2216,6 +2218,16 @@ int process_session_node(xmlNodePtr session_node, co=
nst char *session_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 config_element_output)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* output */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 output_node =3D node;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!shm_pat=
h &amp;&amp; !strcmp((const char *) node-&gt;name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config_el=
ement_shared_memory_path)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* shared memory path */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xmlChar *node_content =3D xmlNodeGetContent(node);<br></blockquot=
e><div><br></div><div>As per the libxml docs[1]:<br></div><div><br></div><d=
iv>xmlNodeGetContent():<br></div><div><div>Returns:<span style=3D"white-spa=
ce:pre-wrap">=C2=A0</span>a new #xmlChar * or NULL if no content is availab=
le. It&#39;s up to the caller to free the memory with xmlFree().</div></div=
><div><br></div><div>I have added an xmlFree() call to the teardown.</div><=
div><br></div><div>[1] <a href=3D"http://xmlsoft.org/html/libxml-tree.html#=
xmlNodeGetContent" target=3D"_blank">http://xmlsoft.org/html/libxml-tree.ht=
ml#xmlNodeGetContent</a><br></div><div><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!node_content) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -LTTNG_ERR_NOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0shm_path =3D (char *) node_content;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* attributes, snapshot_mode or live_timer_interval */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xmlNodePtr attributes_child =3D<br>
@@ -2356,6 +2368,13 @@ domain_init_error:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (shm_path) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D lttng_set_s=
ession_shm_path(name, shm_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (node =3D xmlFirstElementChild(domains_node=
); node;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D xmlNextEle=
mentSibling(node)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D process_dom=
ain_node(node, name);<br>
diff --git a/src/common/config/session.xsd b/src/common/config/session.xsd<=
br>
index 6d74e85..0a7458d 100644<br>
--- a/src/common/config/session.xsd<br>
+++ b/src/common/config/session.xsd<br>
@@ -279,6 +279,7 @@ elementFormDefault=3D&quot;qualified&quot; version=3D&q=
uot;2.5&quot;&gt;<br>
=C2=A0&lt;xs:complexType name=3D&quot;session_type&quot;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;xs:all&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;xs:element name=
=3D&quot;name&quot; type=3D&quot;name_type&quot;/&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;xs:element name=
=3D&quot;shared_memory_path&quot; type=3D&quot;xs:string&quot; minOccurs=3D=
&quot;0&quot;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;xs:element name=
=3D&quot;domains&quot; type=3D&quot;domain_list_type&quot; minOccurs=3D&quo=
t;0&quot;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;xs:element name=
=3D&quot;started&quot; type=3D&quot;xs:boolean&quot; default=3D&quot;0&quot=
; minOccurs=3D&quot;0&quot;/&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;xs:element name=
=3D&quot;attributes&quot; type=3D&quot;session_attributes_type&quot; minOcc=
urs=3D&quot;0&quot;/&gt;<br>
<span><font color=3D"#888888">--<br>
2.1.4<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://ww=
w.efficios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div></div>

--001a11c1dc9440086405195ab12b--


--===============0875720718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0875720718==--
