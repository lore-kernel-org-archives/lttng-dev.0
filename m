From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: take RCU read-side lock
 within hash table functions
Date: Sun, 16 Aug 2015 20:35:37 -0400
Message-ID: <CA+jJMxsC84GuAgpiExMsOuvZ0E12yNv-YHXrO=Qf_yx6v9uFyQ__40623.9160955467$1439771815$gmane$org@mail.gmail.com>
References: <1438898541-26089-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0662040380=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZR8Os-0003su-VN
 for lttng-dev@lists.lttng.org; Sun, 16 Aug 2015 20:35:44 -0400
Received: by ykll84 with SMTP id l84so49282066ykl.0
 for <lttng-dev@lists.lttng.org>; Sun, 16 Aug 2015 17:35:37 -0700 (PDT)
In-Reply-To: <1438898541-26089-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0662040380==
Content-Type: multipart/alternative; boundary=001a1139cf22f77c9d051d76faa1

--001a1139cf22f77c9d051d76faa1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged in master, stable-2.7, stable-2.6 and stable-2.5.

Thanks,
J=C3=A9r=C3=A9mie
On Aug 6, 2015 15:02, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
wrote:

> After review, a great deal of caller sites miss the RCU read-side lock
> when using the hash table modification functions. This is a case where
> having a slight performance degradation might be worthwhile if we can be
> a bit more stability. So instead of playing whack-a-mole, add the RCU
> read-side lock in the hash table modification functions to ensure
> protection from ABA.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/hashtable/hashtable.c | 45
> +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/src/common/hashtable/hashtable.c
> b/src/common/hashtable/hashtable.c
> index 3a38cbf..d1049d1 100644
> --- a/src/common/hashtable/hashtable.c
> +++ b/src/common/hashtable/hashtable.c
> @@ -34,6 +34,13 @@ static unsigned long min_hash_alloc_size =3D 1;
>  static unsigned long max_hash_buckets_size =3D 0;
>
>  /*
> + * Getter/lookup functions need to be called with RCU read-side lock
> + * held. However, modification functions (add, add_unique, replace, del)
> + * take the RCU lock internally, so it does not matter whether the
> + * caller hold the RCU lock or not.
> + */
> +
> +/*
>   * Match function for string node.
>   */
>  static int match_str(struct cds_lfht_node *node, const void *key)
> @@ -253,8 +260,11 @@ void lttng_ht_add_unique_str(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_unique(ht->ht, ht->hash_fct(node->key,
> lttng_ht_seed),
>                         ht->match_fct, node->key, &node->node);
> +       rcu_read_unlock();
>         assert(node_ptr =3D=3D &node->node);
>  }
>
> @@ -268,8 +278,11 @@ void lttng_ht_add_str(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         cds_lfht_add(ht->ht, ht->hash_fct(node->key, lttng_ht_seed),
>                         &node->node);
> +       rcu_read_unlock();
>  }
>
>  /*
> @@ -281,8 +294,11 @@ void lttng_ht_add_ulong(struct lttng_ht *ht, struct
> lttng_ht_node_ulong *node)
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         cds_lfht_add(ht->ht, ht->hash_fct((void *) node->key,
> lttng_ht_seed),
>                         &node->node);
> +       rcu_read_unlock();
>  }
>
>  /*
> @@ -295,8 +311,11 @@ void lttng_ht_add_u64(struct lttng_ht *ht, struct
> lttng_ht_node_u64 *node)
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         cds_lfht_add(ht->ht, ht->hash_fct(&node->key, lttng_ht_seed),
>                         &node->node);
> +       rcu_read_unlock();
>  }
>
>  /*
> @@ -310,9 +329,12 @@ void lttng_ht_add_unique_ulong(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_unique(ht->ht,
>                         ht->hash_fct((void *) node->key, lttng_ht_seed),
> ht->match_fct,
>                         (void *) node->key, &node->node);
> +       rcu_read_unlock();
>         assert(node_ptr =3D=3D &node->node);
>  }
>
> @@ -327,9 +349,12 @@ void lttng_ht_add_unique_u64(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_unique(ht->ht,
>                         ht->hash_fct(&node->key, lttng_ht_seed),
> ht->match_fct,
>                         &node->key, &node->node);
> +       rcu_read_unlock();
>         assert(node_ptr =3D=3D &node->node);
>  }
>
> @@ -344,9 +369,12 @@ void lttng_ht_add_unique_two_u64(struct lttng_ht *ht=
,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_unique(ht->ht,
>                         ht->hash_fct((void *) &node->key, lttng_ht_seed),
> ht->match_fct,
>                         (void *) &node->key, &node->node);
> +       rcu_read_unlock();
>         assert(node_ptr =3D=3D &node->node);
>  }
>
> @@ -361,9 +389,12 @@ struct lttng_ht_node_ulong
> *lttng_ht_add_replace_ulong(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_replace(ht->ht,
>                         ht->hash_fct((void *) node->key, lttng_ht_seed),
> ht->match_fct,
>                         (void *) node->key, &node->node);
> +       rcu_read_unlock();
>         if (!node_ptr) {
>                 return NULL;
>         } else {
> @@ -383,9 +414,12 @@ struct lttng_ht_node_u64
> *lttng_ht_add_replace_u64(struct lttng_ht *ht,
>         assert(ht->ht);
>         assert(node);
>
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
>         node_ptr =3D cds_lfht_add_replace(ht->ht,
>                         ht->hash_fct(&node->key, lttng_ht_seed),
> ht->match_fct,
>                         &node->key, &node->node);
> +       rcu_read_unlock();
>         if (!node_ptr) {
>                 return NULL;
>         } else {
> @@ -399,11 +433,17 @@ struct lttng_ht_node_u64
> *lttng_ht_add_replace_u64(struct lttng_ht *ht,
>   */
>  int lttng_ht_del(struct lttng_ht *ht, struct lttng_ht_iter *iter)
>  {
> +       int ret;
> +
>         assert(ht);
>         assert(ht->ht);
>         assert(iter);
>
> -       return cds_lfht_del(ht->ht, iter->iter.node);
> +       /* RCU read lock protects from ABA. */
> +       rcu_read_lock();
> +       ret =3D cds_lfht_del(ht->ht, iter->iter.node);
> +       rcu_read_unlock();
> +       return ret;
>  }
>
>  /*
> @@ -441,7 +481,10 @@ unsigned long lttng_ht_get_count(struct lttng_ht *ht=
)
>         assert(ht);
>         assert(ht->ht);
>
> +       /* RCU read lock protects from ABA and allows RCU traversal. */
> +       rcu_read_lock();
>         cds_lfht_count_nodes(ht->ht, &scb, &count, &sca);
> +       rcu_read_unlock();
>
>         return count;
>  }
> --
> 2.1.4
>
>

--001a1139cf22f77c9d051d76faa1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Merged in master, stable-2.7, stable-2.6 and stable-2.5.</p>
<p dir=3D"ltr">Thanks,<br>
J=C3=A9r=C3=A9mie</p>
<div class=3D"gmail_quote">On Aug 6, 2015 15:02, &quot;Mathieu Desnoyers&qu=
ot; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers=
@efficios.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">After review, a great deal of caller sites miss the RCU read-side =
lock<br>
when using the hash table modification functions. This is a case where<br>
having a slight performance degradation might be worthwhile if we can be<br=
>
a bit more stability. So instead of playing whack-a-mole, add the RCU<br>
read-side lock in the hash table modification functions to ensure<br>
protection from ABA.<br>
<br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
=C2=A0src/common/hashtable/hashtable.c | 45 +++++++++++++++++++++++++++++++=
++++++++-<br>
=C2=A01 file changed, 44 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/src/common/hashtable/hashtable.c b/src/common/hashtable/hashta=
ble.c<br>
index 3a38cbf..d1049d1 100644<br>
--- a/src/common/hashtable/hashtable.c<br>
+++ b/src/common/hashtable/hashtable.c<br>
@@ -34,6 +34,13 @@ static unsigned long min_hash_alloc_size =3D 1;<br>
=C2=A0static unsigned long max_hash_buckets_size =3D 0;<br>
<br>
=C2=A0/*<br>
+ * Getter/lookup functions need to be called with RCU read-side lock<br>
+ * held. However, modification functions (add, add_unique, replace, del)<b=
r>
+ * take the RCU lock internally, so it does not matter whether the<br>
+ * caller hold the RCU lock or not.<br>
+ */<br>
+<br>
+/*<br>
=C2=A0 * Match function for string node.<br>
=C2=A0 */<br>
=C2=A0static int match_str(struct cds_lfht_node *node, const void *key)<br>
@@ -253,8 +260,11 @@ void lttng_ht_add_unique_str(struct lttng_ht *ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_unique(ht-&gt;ht, ht-=
&gt;hash_fct(node-&gt;key, lttng_ht_seed),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;match_fct, node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node_ptr =3D=3D &amp;node-&gt;node);<br>
=C2=A0}<br>
<br>
@@ -268,8 +278,11 @@ void lttng_ht_add_str(struct lttng_ht *ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_lfht_add(ht-&gt;ht, ht-&gt;hash_fct(node-&g=
t;key, lttng_ht_seed),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -281,8 +294,11 @@ void lttng_ht_add_ulong(struct lttng_ht *ht, struct lt=
tng_ht_node_ulong *node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_lfht_add(ht-&gt;ht, ht-&gt;hash_fct((void *=
) node-&gt;key, lttng_ht_seed),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -295,8 +311,11 @@ void lttng_ht_add_u64(struct lttng_ht *ht, struct lttn=
g_ht_node_u64 *node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_lfht_add(ht-&gt;ht, ht-&gt;hash_fct(&amp;no=
de-&gt;key, lttng_ht_seed),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -310,9 +329,12 @@ void lttng_ht_add_unique_ulong(struct lttng_ht *ht,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_unique(ht-&gt;ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;hash_fct((void *) node-&gt;key, lttng_ht_seed), ht-&gt;ma=
tch_fct,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (void *) node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node_ptr =3D=3D &amp;node-&gt;node);<br>
=C2=A0}<br>
<br>
@@ -327,9 +349,12 @@ void lttng_ht_add_unique_u64(struct lttng_ht *ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_unique(ht-&gt;ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;hash_fct(&amp;node-&gt;key, lttng_ht_seed), ht-&gt;match_=
fct,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node_ptr =3D=3D &amp;node-&gt;node);<br>
=C2=A0}<br>
<br>
@@ -344,9 +369,12 @@ void lttng_ht_add_unique_two_u64(struct lttng_ht *ht,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_unique(ht-&gt;ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;hash_fct((void *) &amp;node-&gt;key, lttng_ht_seed), ht-&=
gt;match_fct,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (void *) &amp;node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node_ptr =3D=3D &amp;node-&gt;node);<br>
=C2=A0}<br>
<br>
@@ -361,9 +389,12 @@ struct lttng_ht_node_ulong *lttng_ht_add_replace_ulong=
(struct lttng_ht *ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_replace(ht-&gt;ht,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;hash_fct((void *) node-&gt;key, lttng_ht_seed), ht-&gt;ma=
tch_fct,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (void *) node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node_ptr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
@@ -383,9 +414,12 @@ struct lttng_ht_node_u64 *lttng_ht_add_replace_u64(str=
uct lttng_ht *ht,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(node);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 node_ptr =3D cds_lfht_add_replace(ht-&gt;ht,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ht-&gt;hash_fct(&amp;node-&gt;key, lttng_ht_seed), ht-&gt;match_=
fct,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;node-&gt;key, &amp;node-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node_ptr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
@@ -399,11 +433,17 @@ struct lttng_ht_node_u64 *lttng_ht_add_replace_u64(st=
ruct lttng_ht *ht,<br>
=C2=A0 */<br>
=C2=A0int lttng_ht_del(struct lttng_ht *ht, struct lttng_ht_iter *iter)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(iter);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return cds_lfht_del(ht-&gt;ht, iter-&gt;iter.no=
de);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cds_lfht_del(ht-&gt;ht, iter-&gt;iter.n=
ode);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -441,7 +481,10 @@ unsigned long lttng_ht_get_count(struct lttng_ht *ht)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(ht-&gt;ht);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* RCU read lock protects from ABA and allows R=
CU traversal. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cds_lfht_count_nodes(ht-&gt;ht, &amp;scb, &amp;=
count, &amp;sca);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rcu_read_unlock();<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return count;<br>
=C2=A0}<br>
--<br>
2.1.4<br>
<br>
</blockquote></div>

--001a1139cf22f77c9d051d76faa1--


--===============0662040380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0662040380==--
