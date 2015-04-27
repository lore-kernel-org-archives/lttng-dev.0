From: Zifei Tong <zifeitong@gmail.com>
Subject: Re: [PATCH] Fix: multiple definition error with gcc 5.1
Date: Mon, 27 Apr 2015 23:39:20 +0200
Message-ID: <CAJ7wx-Eze7hKh3ZTcxDTREois10BjoQ_118W2W8k4vUQd0bOSg__16624.011231079$1430170847$gmane$org@mail.gmail.com>
References: <1430170305-26566-1-git-send-email-zifeitong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <soariez@gmail.com>) id 1Ymql4-0005Gj-1g
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 17:40:07 -0400
Received: by oiko83 with SMTP id o83so101171308oik.1
 for <lttng-dev@lists.lttng.org>; Mon, 27 Apr 2015 14:40:00 -0700 (PDT)
In-Reply-To: <1430170305-26566-1-git-send-email-zifeitong@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I created a minimal reproducer [1] for the UB if you are interested.

[1]: https://gist.github.com/5kg/7304cf74bc0fe13a9f70

Thanks,
Zifei Tong
