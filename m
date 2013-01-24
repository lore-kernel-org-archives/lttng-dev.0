From: Liu Yuan <namei.unix@gmail.com>
Subject: Re: Query on the rculist
Date: Thu, 24 Jan 2013 13:22:13 +0800
Message-ID: <5100C505.6080505__31683.7577768185$1359005057$gmane$org@gmail.com>
References: <50FCA183.8030201@gmail.com> <20130121141645.GB31140@Krystal>
	<50FEA109.6060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <namei.unix@gmail.com>) id 1TyFGb-0000Bw-5G
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 00:22:25 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so5221275pbc.28
	for <lttng-dev@lists.lttng.org>; Wed, 23 Jan 2013 21:22:19 -0800 (PST)
In-Reply-To: <50FEA109.6060404@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <eag0628@gmail.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 01/22/2013 10:24 PM, Lai Jiangshan wrote:
> Add a trivial comment.
> 
> There is no list_del_init_rcu(), "init" hurts "rcu".
> If you need a re-initialized object after deletion, you should use
> synchronzie_rcu():
> 
> list_del_rcu();
> synchronize_rcu();
> CDS_INIT_LIST_HEAD();

Thanks, note taken. Mathieu, could you add this as comment for
rculist.h? It will save people from finding list_dei_init_rcu().

Yuan
