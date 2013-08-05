From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Mandatory name for some field in a CTF trace
Date: Mon, 05 Aug 2013 15:39:43 -0400
Message-ID: <51FFFF7F.5000901__39466.9209876612$1375731645$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1V6QdD-000506-DW
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 15:39:56 -0400
Received: by mail-yh0-f51.google.com with SMTP id 29so1637917yhl.24
	for <lttng-dev@lists.lttng.org>; Mon, 05 Aug 2013 12:39:45 -0700 (PDT)
Received: from [132.207.72.30] (dyn30.dorsal.polymtl.ca. [132.207.72.30])
	by mx.google.com with ESMTPSA id a62sm935097yhk.4.2013.08.05.12.39.44
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 12:39:45 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

I'm writing a CTF writer for perf and I'm discovering that some
mandatory fields for a CTF trace are not documented.
We must call the time field "timestamp" and the id field mapping event
to their description must be "id".
Looking at parser source code, we can find other field like that.

Would it be interesting to add this information in the CTF spec? Or
should we write a second spec on the side for that kind of information?
The question we want to answer is "What do I need to put in a CTF file
to make it possible for a viewer to display it?"

Yannick
