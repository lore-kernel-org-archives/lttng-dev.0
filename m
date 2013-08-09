From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.4 RFC PATCH] Kernel
	consumer	generate indexes
Date: Fri, 9 Aug 2013 11:55:05 -0400
Message-ID: <20130809155505.GF13969__37449.6047189043$1376063822$gmane$org@Krystal>
References: <1376061469-30350-1-git-send-email-jdesfossez@efficios.com>
	<20130809154253.GA13969@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7p1u-0007ux-4H
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:55:11 -0400
Content-Disposition: inline
In-Reply-To: <20130809154253.GA13969@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Julien Desfossez (jdesfossez@efficios.com) wrote:
[...]
> > +static int create_index_file(struct lttng_consumer_stream *stream)
> > +{
> > +	char *index_name;
> > +	struct lttng_packet_index_file_hdr hdr;
> > +	int ret;
> > +
> > +	ret = asprintf(&index_name, "%s.idx", stream->name);
> > +	if (ret < 0) {
> > +		PERROR("Allocating index name");
> > +		goto error;
> > +	}
> > +	ret = utils_create_stream_file(stream->chan->pathname,
> > +			index_name, 0, 0, stream->uid,
> > +			stream->gid);
> > +	free(index_name);
> > +	if (ret < 0) {
> > +		goto error;
> > +	}
> > +
> > +	stream->index_fd = ret;
> > +	strncpy(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic));
> 
> If you use strncpy, it's because you don't trust that INDEX_MAGIC will
> always fit within hdr.magic. If it is the case, then you should always
> do:
> 
> hdr.magic[sizeof(hdr.magic) - 1] = '\0';
> 
> after the strncpy.

In this case, you'll want to use a memcpy, since you clearly copy from a
fixed-sized to a fixed-sized area, which need to have both the same
size.

  memcpy(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic));

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
