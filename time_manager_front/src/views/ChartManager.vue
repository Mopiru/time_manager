<template>
<div class="chartmanager">

<div>
    <donut-chart 
        id="donut" 
        :data='[
        {"label": "Hours Done", "value": workingtime_hours},
        {"label": "Hours Left", "value": workhours},
        ]'
        colors='[ "#FF6384", "#36A2EB" ]' 
        resize="true">
    </donut-chart>
</div>

<div>
    <bar-chart 
        id="bar" 
        :data='tabledate' 
        xkey="day"
        ykeys='["hour"]'
        bar-colors='["#36A2EB"]'
        grid="true"
        grid-text-weight="bold"
        resize="true">
    </bar-chart>
</div>

</div>


</template>

<script>
import axios from 'axios';
import moment from 'moment'
import { DonutChart } from 'vue-morris'
import { BarChart } from 'vue-morris'

export default {
    name: 'ChartManager',
    components: {
        DonutChart,
        BarChart
    },
    data() {
        return {
            info: null,
            user: 0,
            workingtime_hours: 0,
            workhours: 0,
            tabledate: [],
            tableCompare: []
        }
    },
    async mounted() {

        
        let userObj = JSON.parse(localStorage.user);
        const workingtimes = await axios.get("http://127.0.0.1:4000/api/v1/workingtimes/"+userObj.userId)
        this.info = workingtimes.data.data
        console.log(workingtimes.data)
        console.log(this.info)
        if (this.info.length>0) {
            let i = 0
            console.log(this.info.length)
            for (let index =this.info.length -1 ; index >= 0 ; index--) {
                if (i < 5){
                    let starting=  moment(String(this.info[index].start)).format('YYYY-MM-DD HH:mm:ss')
                    let dates = moment(String(this.info[index].start)).format('YYYY-MM-DD')
                    let ending=  moment(String(this.info[index].end)).format('YYYY-MM-DD HH:mm:ss')
                    let ms = moment(ending).diff(moment(starting));
                    let d = moment.duration(ms);
                    let s = Math.floor(d.asHours()) + moment.utc(ms).format(":mm:ss");
                    console.log(s)
                    this.workingtime_hours+= Number(String(s).slice(0,1))
                    console.log(this.workingtime_hours)
                    i++;
                    this.tabledate.push({day: dates, hour: Number(String(s).slice(0,1))})
                }
            }
            if (this.workingtime_hours< 35){
                this.workhours= 35-this.workingtime_hours
            }
            this.donutData[0].value = Number(this.workingtime_hours)
            this.donutData[1].value = Number(this.workhours)
            console.log(this.workingtime_hours)
        }
    },
    watch: {
        change: function () {
            axios
                .get('http://localhost:4000/api/workingtimes/all/' + this.user + '')
                .then(response => (this.info = response.data))

            console.log(this.info)
        }
    }
}
</script>

<style>

</style>
