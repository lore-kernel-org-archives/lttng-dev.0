From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: [lttng-ust] duplicated struct
 ustctl_consumer_channel_attr
Date: Fri, 10 May 2019 15:35:38 -0400
Message-ID: <46193ce3-1320-a982-2cb2-7f5d11596195__34769.7041391925$1557516959$gmane$org@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 4510mq4Sn6z1KGp
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 15:35:39 -0400 (EDT)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

As suggested by Jonathan [1], I should start a new email thread.

Why are there 2 identical declarations of struct ustctl_consumer_channel_attr
(one in lttng-ust, one in lttng-tools) instead of just one ?

It just seems redundant to me.


[sboisvert@GT480:lttng-ust]$ grep "struct ustctl_consumer_channel_attr {" -A 11 include/lttng/ust-ctl.h
struct ustctl_consumer_channel_attr {
	enum lttng_ust_chan_type type;
	uint64_t subbuf_size;			/* bytes */
	uint64_t num_subbuf;			/* power of 2 */
	int overwrite;				/* 1: overwrite, 0: discard */
	unsigned int switch_timer_interval;	/* usec */
	unsigned int read_timer_interval;	/* usec */
	enum lttng_ust_output output;		/* splice, mmap */
	uint32_t chan_id;			/* channel ID */
	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
	int64_t blocking_timeout;			/* Blocking timeout (usec) */
} LTTNG_PACKED;


[sboisvert@GT480:lttng-tools]$ grep "struct ustctl_consumer_channel_attr {" -A 11 src/bin/lttng-sessiond/lttng-ust-ctl.h
struct ustctl_consumer_channel_attr {
	enum lttng_ust_chan_type type;
	uint64_t subbuf_size;			/* bytes */
	uint64_t num_subbuf;			/* power of 2 */
	int overwrite;				/* 1: overwrite, 0: discard */
	unsigned int switch_timer_interval;	/* usec */
	unsigned int read_timer_interval;	/* usec */
	enum lttng_ust_output output;		/* splice, mmap */
	uint32_t chan_id;			/* channel ID */
	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
	int64_t blocking_timeout;			/* Blocking timeout (usec) */
} LTTNG_PACKED;


----
[1] https://lists.lttng.org/pipermail/lttng-dev/2019-May/028894.html
