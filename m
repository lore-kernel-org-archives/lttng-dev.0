From: Hui Zhu <teawater@gmail.com>
Subject: [Question] the return of babeltrace's bt_context_create
Date: Tue, 21 Aug 2012 10:17:58 +0800
Message-ID: <CANFwon3dYkyqf4K+gCZ35-eEvVwNRP56pYOF0wwkHDPY-FxyDg__49078.6428018056$1345515549$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1T3e3I-0008Ha-5s
	for lttng-dev@lists.lttng.org; Mon, 20 Aug 2012 22:18:44 -0400
Received: by vcbfl11 with SMTP id fl11so7234222vcb.35
	for <lttng-dev@lists.lttng.org>; Mon, 20 Aug 2012 19:18:38 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

The comments of this function said:
Returns an allocated context on success and NULL on error

But when babeltrace use this function, it didn't check the return
value of bt_context_create:
	ctx = bt_context_create();

	ret = bt_context_add_traces_recursive(ctx, opt_input_path,
			opt_input_format, NULL);

Could you tell me why?  Thanks a lot.

Best,
Hui
