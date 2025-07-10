Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB163C83F1B
	for <lttng-dev@archiver.kernel.org>; Thu, 10 Jul 2025 14:40:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bdHZq556Fz1BVf
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1752158452;
	b=B42iU48bdtMKYAFWipvxQQm65z8WS1P638znpyC0FrR6hlVlMpEnVNOEKtbKdBAPIadq
	 atN3UhFnzgE6y13YLDKMYIgocVH1xyj85VmbUCdERkDqgyYbW84N5WbqJOn4x0lHlslyV
	 muoIR7OH7/mtLiT0465dmNuJSeKFyoMCipX9Bcx5OdIZT8z2/oc1bTr5mNQvjwdQkQViS
	 8ked9keFWUKSWikVssMEVnHypWXSZYJ15XUCLO5SEZnBEIGfYgS2DQImPUgv7Ax6/eDf0
	 qXHTf1Ng2izxw92Z8zof3WIzRGXeZjAVFOwOhdpsQ8wtbO2hiFE/ByyhYK4w4ctvghw==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1752158452;
	h=DKIM-Signature:Mime-Version:Subject:Date:Message-Id:To:From:From;
	bh=pXAkhlU/eLcrtxWZAeGZL/u0L1oZqHqBXbL/sFwPLNM=;
	b=PrwoZj8aM6MzVDtmFWXlWHLpGYSl41U0IkEDd+uiJqps6bLjhLUAJYs0Wf5mCysnKb4W
	 54qkxgMpb2Oj0luWRIUzN0igbavK4GPIZRpEAQO5g0z2XP5NQyVQD8YBYjD8/Kc2Z8Rgg
	 XuT+zeHR4Y1RoXdnFEJZ2I5LfVXy5w9E0hG+AZ3nBhXHCmvY8f93BTmk2c9O2YCqlFmXN
	 5d5x1pD7WczXE2wLi6qR76HpuwQQjku37UUHquuk3hEJZcF1et7j7mXPeZl3ELz6Z//nV
	 PPIctR576lJf4Vgu4gHufCaxiKt/1pgMZKIsr27NgNkGVTIFEVGpcOW449pfhkbBFSA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bdHZq556Fz1BVf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1752158452;
	bh=pXAkhlU/eLcrtxWZAeGZL/u0L1oZqHqBXbL/sFwPLNM=;
	h=Subject:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=XiIz+IiB0V50QoYpGwV9ExtEvumngNTYxfoozwNQnxPmq+jYPg3QPowRhFoeZUL5c
	 6ZRs4OCjsABNfxPQyjBsDh90YsT/tgVBf6q1BqXY3R15BamV5qJbojWELCrL3v2+Ca
	 YNCPY4SbvUtpjF228cKmSVYrsGlwXdQgJ/VNQ0ECpk8a36XWRg4QUYdqoadF087zEk
	 03EJGmbgO4ljxAG3BHYC6hvYPP9aX0gPflGMnBIROjQeCyjEUhmI+muVyJAWCRaQue
	 TURGFulrhKq4Cp5nRXJ8Er9WLXM6I0AK/DTU5JtMqIV75jBL9DxVo11EqI9C6Bxnpu
	 DvoP1zuOdfG5g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bdHZq556Fz1BVf;
	Thu, 10 Jul 2025 10:40:51 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bdHZp00rbz1B7q
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bdHZp00rbz1B7q
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by lists.lttng.org (Postfix) with ESMTPS id 4bdHZp00rbz1B7q
 for <lttng-dev@lists.lttng.org>; Thu, 10 Jul 2025 10:40:49 -0400 (EDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id D3A7EEC0170;
 Thu, 10 Jul 2025 10:40:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Thu, 10 Jul 2025 10:40:43 -0400
X-ME-Sender: <xms:69BvaMJHMZznwzeqnWETlhQ7i88sh18KcAR3DEsCrh_ymrhpgfE8-g>
 <xme:69BvaGvnNZh8_0TR_s7hfaq_YnkM2jo7qeCPz9ZQJlbcQ6QyAJwOehnFpOB977iMA
 V9Uv3jC95AY_Xn34Tw>
X-ME-Received: <xmr:69BvaJS4oTaeu4_zRAcGFhs6zGUA6bgqIT1MhhDVNopp5ONJSLkJ1kS7jkTZMwbIlSrzq_nDs0eYrFry24T3OV4O--iNmQ5z5pI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdejtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepqfhnughrvghj
 ucfuuhhrupcuoehonhgurhgvjhesshhurhihrdhorhhgqeenucggtffrrghtthgvrhhnpe
 ejvddtvdeludefteeuveejueehueekudduhfektefhiedtfeduffekfeefveekveenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehonhgurhgvjh
 esshhurhihrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
 rhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhoshdrtg
 homhdprhgtphhtthhopehlthhtnhhgqdguvghvsehlihhsthhsrdhlthhtnhhgrdhorhhg
 pdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepoh
 guihhonhesvghffhhitghiohhsrdgtohhm
X-ME-Proxy: <xmx:69BvaMPEYbzsoKj0TdJ-eNRAqpW26d3Hbqi1muH2cecpY2a633iZ6A>
 <xmx:69BvaOZGwtgAZfwOR4nL5tHh4uVLGF5xHZayCMa_UFJreIxc1FWxsA>
 <xmx:69BvaGznXS5KmjWgXREuDIcEg30hCuJWwxh3VWsjXGyyAXK6H-Ckhw>
 <xmx:69BvaJJ3ozZs8e2L_PpYmqqa4eQNeQJSlBOMo6IH_sJvABQ9O_54_w>
 <xmx:69BvaAybd8_aYVNHCqHTRAVvMtAqs-RzdhwbXCgpvM7qyFZef8EE8gQt>
Feedback-ID: ida81469e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 10:40:42 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: cds_lfht_new() clarification - init vs min
In-Reply-To: <23ad5696-f88b-41e3-ae37-e1c9fd411822@efficios.com>
Date: Thu, 10 Jul 2025 16:40:29 +0200
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>,
 Olivier Dion <odion@efficios.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5544E79A-115A-4CD4-BA72-B62FE97BBBB2@sury.org>
References: <0178CA60-19CE-4E0A-AEEB-5E9DEAAB460E@sury.org>
 <23ad5696-f88b-41e3-ae37-e1c9fd411822@efficios.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Ond=C5=99ej_Sur=C3=BD_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?utf-8?B?T25kxZllaiBTdXLDvQ==?= <ondrej@sury.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


> On 10. 7. 2025, at 16:05, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
> On 2025-07-09 14:57, Ond=C5=99ej Sur=C3=BD via lttng-dev wrote:
>> Hi,
>> as the answer to this might be useful to more people, I am asking =
here:
>> The cds_lfht_new documentation specifies 3 sizes.
>>  * cds_lfht_new - allocate a hash table.
>>  * @init_size: number of buckets to allocate initially. Must be power =
of two.
>>  * @min_nr_alloc_buckets: the minimum number of allocated buckets.
>>  *                        (must be power of two)
>>  * @max_nr_buckets: the maximum number of hash table buckets allowed.
>>  *                  (must be power of two, 0 is accepted, means
>>  *                  "infinite")
>> The max number of buckets is obvious, but the interaction between =
init
>> and min is confusing.
>> If I am reading the code right, then init_size < min_nr_alloc_buckets =
have no
>> effect, the buckets table will be at least 1 << min_nr_alloc_buckets.
>=20
> You are correct that the documentation of interaction between =
init_size
> and min_nr_alloc_buckets should be improved. Especially the semantic
> of "allocated" vs "initialized" buckets.
>=20
> Re-reading the code, here is my understanding:
>=20
> - The init_size parameter is responsible for initializing a certain
>  number of buckets at hash table creation (during the call to
>  cds_lfht_new()) and for setting an initial resize target to the
>  init_size value. It allocates the buckets memory _and_ chains
>  those buckets into the hash table.
>=20
> - The min_nr_alloc_buckets only acts as a lower bound below which
>  the hash table resize algorithm won't free the _memory_ used for
>  buckets below that threshold and will keep the buckets allocated even
>  when the hash table size shrinks. It does not affect the fact buckets
>  are unlinked from the hash table when it shrinks below that threshold
>  though, it only keeps their memory allocated.
>=20
>  This parameter only applies when an explicit cds_lfht_resize,
>  cds_lfht_resize_lazy_count are done, or when the hash table is
>  created with the CDS_LFHT_AUTO_RESIZE flag.
>=20
> So my understanding does not match yours. In case I missed something,
> what is leading you conclude that the
> "buckets table will be at least 1 << min_nr_alloc_buckets"
> at hash table creation when init_size < min_nr_alloc_buckets ?

It's not so obvious from the mmap implementation, but the mm-order has:

static
void cds_lfht_alloc_bucket_table(struct cds_lfht *ht, unsigned long =
order)
{
        if (order =3D=3D 0) {
                ht->tbl_order[0] =3D ht->alloc->calloc(ht->alloc->state,
                        ht->min_nr_alloc_buckets, sizeof(struct =
cds_lfht_node));
                urcu_posix_assert(ht->tbl_order[0]);
        } else if (order > ht->min_alloc_buckets_order) {
                ht->tbl_order[order] =3D =
ht->alloc->calloc(ht->alloc->state,
                        1UL << (order -1), sizeof(struct =
cds_lfht_node));
                urcu_posix_assert(ht->tbl_order[order]);
        }
        /* Nothing to do for 0 < order && order <=3D =
ht->min_alloc_buckets_order */
}

Similar code is in the mm-chunk.  The mmap allocates largest mmap and =
then it marks
the pages as needed, so it is bit hidden behind mmap semantics, but it =
also populates
min_nr_alloc_buckets:

                /* large table */
                ht->tbl_mmap =3D memory_map(ht->max_nr_buckets
                        * sizeof(*ht->tbl_mmap));
                memory_populate(ht->tbl_mmap,
                        ht->min_nr_alloc_buckets * =
sizeof(*ht->tbl_mmap));

and cds_lfht_alloc_bucket_table(..., 0) is called when initializing the =
from cds_lfht_new(),
so my assumption was that the buckets table is .tbl_<impl> and that's =
always at least
min_nr_alloc_buckets large.

The loop in cds_lfht_create_bucket() then does not change the underlying =
table size,
but it doesn't initialize buckets for orders > init size & < =
min_nr_alloc_size.

>> But what happens if init_size > min_nr_alloc_buckets? It feels like =
it will work
>> as expected if you pre-populate the table, but if you use it =
"normally", e.g. there
>> could be single add / del, the table will shrink immediately.
>=20
> In that case, cds_lfht_new would allocate and initialize buckets based
> on init_size, and set an initial resize_target value based on =
init_size.
>=20
> For a hash table created with the CDS_LFHT_AUTO_RESIZE flag, indeed if
> the init_size > min_nr_alloc_buckets, doing a add/del will indeed
> trigger a hash table auto-resize, which will unlink and free buckets
> between min_nr_alloc_buckets and init_size, and will just unlink =
buckets
> (not free memory) below min_nr_alloc_buckets.
>=20
> So it does not make much sense to have a large init_size value for an
> auto-resize hash table, because it will very undo initialization
> and allocation soon after creation when the first items are added
> and removed.

However, it could make sense to have init_size smaller than =
min_nr_alloc_size
to make the bucket initialization deferred, but until we reach min_nr... =
the table
will never auto-shrink.

> For a hash table created without auto-resize, then the behavior =
depends
> on the explicit resizes done with cds_lfht_resize,
> cds_lfht_resize_lazy_grow, and cds_lfht_resize_lazy_count, so it makes
> more sense to have a larger init_size value (even larger than
> min_nr_alloc_buckets).
>=20
> Does this explanation help ?

Absolutely, I was also thinking inside the CDS_LFHT_AUTO_RESIZE flag
because it is ubiquitous in our code and you made me realize that the =
resizes
could be done automatically.

Ondrej
--
Ond=C5=99ej Sur=C3=BD (He/Him)
ondrej@sury.org


