From: Simon Marchi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: bt2 Python quick start/examples?
Date: Thu, 12 Mar 2020 11:58:02 -0400
Message-ID: <aef675ff-10d2-9928-9e32-77e78b7a9603@simark.ca>
References: <CADtyBo5-2Dos_qAL=J3GjQReQ=e52U8sbUaN6-wx7kefaDZycA@mail.gmail.com>
 <20200312141841.GB16241@joraj-alpa>
Reply-To: Simon Marchi <simark@simark.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 48dYQ942Ppz1HHY
 for <lttng-dev@lists.lttng.org>; Thu, 12 Mar 2020 11:58:09 -0400 (EDT)
In-Reply-To: <20200312141841.GB16241@joraj-alpa>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, Rocky Dunlap <dunlap@ucar.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2020-03-12 10:18 a.m., Jonathan Rajotte-Julien via lttng-dev wrote:
> Hi,
> 
> On Wed, Mar 11, 2020 at 10:56:24PM -0400, Rocky Dunlap via lttng-dev wrote:
>> I see that the bt2 Python documentation is not yet ready:
>> https://babeltrace.org/docs/v2.0/python/bt2/
> 
> Slowly getting there.
> 
>>
>> In lieu of that, where is the best place to find at least a few examples of
>> using the bt2 Python API for basic trace processing tasks?
> 
> Simon Marchi have some examples [1] that have been used in his talk [2][3].
> 
> Hope this helps a bit.
> 
> 
> [1] https://github.com/simark/babeltrace-fun-plugins
> [2] https://www.youtube.com/watch?v=P3cPISvW444&feature=youtu.be
> [3] https://tracingsummit.org/ts/2019/files/Tracingsummit2019-babeltrace2-marchi.pdf

In my presentation, I only touched the subject of writing component classes in
Python.

I think that what many people are looking for is how to read a trace from
Python, perhaps using existing component classes, to quickly
prototype/implement some analysis.  So let me provide some small examples here
to get people started, until the formal documentation is completed.

If all you want to do is iterate on all the events of a trace or trace
collection, then the most convenient/high-level entry point is the
bt2.TraceCollectionMessageIterator class.  It works similarly to the Babeltrace
2 CLI's convert command, in that you can just pass it an input string (a file
path, a directory path or an arbitrary string recognized by some source
component class) and it will use the auto-discovery mechanism to figure out
which source components to instantiate.  You can also pass it more precise
configurations of components to instantiate if needed, as well as various flags
similar to what the CLI's convert command accepts (begin, end,
stream-intersection).

Here's a simple example that iterates on an LTTng kernel trace:

    import bt2

    it = bt2.TraceCollectionMessageIterator(
        "/home/smarchi/lttng-traces/auto-20191016-165642"
    )
    for msg in it:
        if type(msg) == bt2._EventMessageConst:
            ev = msg.event
            if ev.cls.name == "sched_switch":
                cpu = ev.packet.context_field["cpu_id"]
                prev_tid = ev.payload_field["prev_tid"]
                next_tid = ev.payload_field["next_tid"]
                print(
                    "cpu {}: switching from tid {} to tid {}".format(
                        cpu, prev_tid, next_tid
                    )
                )

Here's another example that shows how to instantiate a graph manually, add and
connects ports to it and run it.  It connects a "source.text.dmesg" source with
a "sink.text.details" sink and runs the graph until completion.

    import bt2

    g = bt2.Graph()
    source = g.add_component(
        bt2.find_plugin("text").source_component_classes["dmesg"], "source"
    )
    sink = g.add_component(
        bt2.find_plugin("text").sink_component_classes["details"], "sink"
    )
    g.connect_ports(source.output_ports["out"], sink.input_ports["in"])
    g.run()


Without any parameters, the source.text.dmesg component reads on standard
input, so you can execute this example with:

    $ dmesg | python3 example.py

For more examples of what these types can do, you can always look at the test
cases:

    https://github.com/efficios/babeltrace/tree/master/tests/bindings/python/bt2

Hope this helps for the moment,

Simon
