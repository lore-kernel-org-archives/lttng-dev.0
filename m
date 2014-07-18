From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] perf to ctf converter
Date: Fri, 18 Jul 2014 18:12:16 +0200
Message-ID: <53C94760.80106@linutronix.de>
References: <20140603163640.GA16279@linutronix.de> <20140714141533.GD17761@krava.redhat.com> <53C9143C.1060905@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53C9143C.1060905@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On 07/18/2014 02:34 PM, Sebastian Andrzej Siewior wrote:
>> I made similar effort in C:
>>
>> ---
>> I made some *VERY* early perf convert example, mostly to try the ctf=
-writer
>> interface.. you can check in here:
>>   https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/log/?h=
=3Dperf/ctf_2
>=20
> Let me try it, maybe I can migrate my effort into one code basis.

=46YI: I rebased your code antop of current tip-tree. The C-API looks
better. Especially since I can evlist__for_each() and create a list of
all events. So the C version might get cuter=85


Sebastian
