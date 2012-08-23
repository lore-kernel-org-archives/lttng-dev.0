From: Hui Zhu <teawater@gmail.com>
Subject: [babeltrace] About the type read and write
Date: Thu, 23 Aug 2012 17:35:12 +0800
Message-ID: <CANFwon1jpk3PYYd-ufUSCgKf693vApFgt5UbyOFnPczYTrSZcQ__11054.5510463$1345714589$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1T4TpW-0008IE-H4
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 05:35:58 -0400
Received: by vcbfl11 with SMTP id fl11so697552vcb.35
	for <lttng-dev@lists.lttng.org>; Thu, 23 Aug 2012 02:35:53 -0700 (PDT)
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

I just tried to use libbabeltrace to read and write the CTF file.  But
I cannot find the api to read some type of CTF for example
CTF_TYPE_ENUM, CTF_TYPE_STRUCT.
And I cannot find the api file to write to the CTF file. (I check the
code of babeltrace-log and found that it use the function that is not
API)

Could you help me with it?

Thanks,
Hui
