# Task Master (Ruby)

Task Master is a command-line tool written in Ruby for generating task reports from CSV data. It provides a simple interface for analyzing and reporting on task-related information.
Features

```
    Generate reports from CSV files containing task data.
    Filter tasks based on various criteria such as status, assignee, etc.
    Sort tasks by different fields.
    Customizable output format.
    Easy-to-use command-line interface.
```

## Installation

### Clone the repository to your local machine:
```
git clone https://github.com/paranormalhacktivity/task_master.git
```
### Navigate to the ruby directory:

```
cd task_master/ruby
```
### Install dependencies:

```
bundle install
```

### Symlink the executable for execution from anywhere:
```
ln -s bin/task_master_rb /usr/local/bin/task_master_rb
```

## Usage

Task Master provides a set of command-line options for generating and customizing reports. Here are some examples of how to use it:

### Generate a report from a CSV file:

```
task_master_rb -r task_list -c ./data/tasks.csv
```

### For help running other reports, check the help menu:
```
task_master_rb -h
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.

